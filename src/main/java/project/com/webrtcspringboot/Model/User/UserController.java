package project.com.webrtcspringboot.Model.User;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import project.com.webrtcspringboot.Model.User.email.EmailController;
import project.com.webrtcspringboot.Model.User.email.GenerateRandomString;
import project.com.webrtcspringboot.Storage.StorageService;

import java.nio.file.Path;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

    private final Map<String, Pair<String, String>> emailMap = new HashMap<>();
    private final UserService userService;
    private final UserRepository userRepository;
    private final StorageService storageService;

    @GetMapping("/signup")
    public String signup(UserCreateForm userCreateForm) {
        return "user/signup_form";
    }

    @PostMapping("/signup")
    public String signup(@Valid UserCreateForm userCreateForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors() || userRepository.findByEmail(userCreateForm.getEmail()) != null) {
            return "user/signup_form";
        }
        if (!userCreateForm.getPassword1().equals(userCreateForm.getPassword2())) {
            bindingResult.rejectValue("password1", "error.userCreateForm", "Passwords do not match");
            return "user/signup_form";
        }
        if (emailMap.containsKey(userCreateForm.getEmail())) {
            Pair<String, String> pair = emailMap.get(userCreateForm.getEmail());
            String verifyCode = pair.getFirst();
            if (pair.getSecond().equals("verified") && verifyCode.equals(userCreateForm.getVerificationStatus())) {
                emailMap.remove(userCreateForm.getEmail());
            }
        } else {
            bindingResult.rejectValue("email", "error.userCreateForm", "Email is not verified");
            return "user/signup_form";
        }

        try {
            this.userService.signup(userCreateForm.getName(), userCreateForm.getEmail(), userCreateForm.getPassword1());
        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            bindingResult.rejectValue("email", "error.userCreateForm", "Email already exists");
            return "user/signup_form";
        }
        catch (Exception e) {
            e.printStackTrace();
            bindingResult.rejectValue("email", "error.userCreateForm", e.getMessage());
            return "user/signup_form";
        }
        return "redirect:/";
    }

    @GetMapping("/login")
    public String login() {
        return "user/login";
    }

    @GetMapping("/profile")
    public String profile(Model model, Principal principal) {
        Users user = this.userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("storageUsage", this.storageService.sizeStorageByUser(user.getName()) / (1024 * 1024));

        if (user.getStatus().equals("Premium")) {
            model.addAttribute("storageLimit", 20);
        } else if (user.getStatus().equals("superPremium")) {
            model.addAttribute("storageLimit", 50);
        } else {
            model.addAttribute("storageLimit", 2);
        }
        return "user/profile";
    }

    @PostMapping("/send_code_email/{email}")
    public @ResponseBody String sendCodeEmail(@RequestParam("email") String email) {
        GenerateRandomString generateRandomString = new GenerateRandomString();
        String verificationCode = generateRandomString.getRandomPassword2(10);
        emailMap.put(email, Pair.of(verificationCode, "verify"));
        EmailController.sendEmailVerifyCode(email, verificationCode);
        return "success";
    }

    @PostMapping("/check_verify_code")
    public @ResponseBody String checkVerifyCode(@RequestParam("email") String email, @RequestParam("verifyCode") String verifyCode) {
        Pair<String, String> pair = emailMap.get(email);
        if (pair != null && pair.getFirst().equals(verifyCode) && pair.getSecond().equals("verify")) {
            emailMap.put(email, Pair.of(verifyCode, "verified"));
            return "success";
        }
        return "fail";
    }

    @PostMapping("/find_password")
    public @ResponseBody String findPassword(@RequestParam("email") String email) {
        this.userService.findPassword(email);
        return "success";
    }

    @PostMapping("/change_password")
    public @ResponseBody String changePassword(@RequestParam("currentPassword") String currentPassword, @RequestParam("newPassword") String newPassword, Principal principal) {
        this.userService.changePassword(principal.getName(), currentPassword, newPassword);
        return "success";
    }

//    request_prof_auth',
    @PostMapping("/request_prof_auth")
    public @ResponseBody String requestProfAuth(Principal principal) {
        Users user = this.userService.findByEmail(principal.getName());
        String email = user.getEmail();
        String name = user.getName();
        this.userService.requestProfAuth(email, name);
        return "success";
    }

    @GetMapping("/storage/detail")
    public String storageDetail(Model model, Principal principal) {
        Users user = this.userService.findByEmail(principal.getName());
        String username = user.getName();
        model.addAttribute("user", user);
        model.addAttribute("storageUsage", this.storageService.sizeStorageByUser(user.getName()) / (1024 * 1024));

        Map<String, Stream<Path>> hierarchy = new HashMap<>();
        // Get all parent directories
        Stream<Path> parentDirectories = this.storageService.loadAll2(username);
        parentDirectories.forEach(parentDir -> {
            String parentDirStr = parentDir.toString();
            Long parentDirId = Long.parseLong(parentDirStr);
            Stream<Path> files = this.storageService.loadAll(parentDirId, username);
            hierarchy.put(parentDir.toString(), files);
        });

        model.addAttribute("hierarchy", hierarchy);
        return "user/storage_detail";
    }

//    <a th:href="@{/user/plan/upgrade}" class="btn btn-primary">요금제 변경</a>
    @GetMapping("/plan/upgrade")
    public String planUpgrade(Model model, Principal principal) {
        Users user = this.userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        return "user/plan_upgrade";
    }
}

