package project.com.webrtcspringboot.Model.User;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @GetMapping("/signup")
    public String signup(UserCreateForm userCreateForm) {
        return "user/signup_form";
    }

    @PostMapping("/signup")
    public String signup(@Valid UserCreateForm userCreateForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "user/signup_form";
        }
        if (!userCreateForm.getPassword1().equals(userCreateForm.getPassword2())) {
            bindingResult.rejectValue("password1", "error.userCreateForm", "Passwords do not match");
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
        Users user = this.userService.findByName(principal.getName());
        model.addAttribute("user", user);
        return "user/profile";
    }
}
