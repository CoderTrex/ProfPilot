package project.com.webrtcspringboot.Model.User;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @GetMapping("/signup")
    public String signup(UserCreateForm userCreateForm) {
        return "User/signup_form";
    }

    @PostMapping("/signup")
    public String signup(@Valid UserCreateForm userCreateForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "User/signup_form";
        }
        if (!userCreateForm.getPassword1().equals(userCreateForm.getPassword2())) {
            bindingResult.rejectValue("password1", "error.userCreateForm", "Passwords do not match");
            return "User/signup_form";
        }
        try {
            this.userService.signup(userCreateForm.getName(), userCreateForm.getEmail(), userCreateForm.getPassword1());

        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            bindingResult.rejectValue("email", "error.userCreateForm", "Email already exists");
            return "User/signup_form";
        }
        catch (Exception e) {
            e.printStackTrace();
            bindingResult.rejectValue("email", "error.userCreateForm", e.getMessage());
            return "User/signup_form";
        }
        return "redirect:/";
    }


    @GetMapping("/login")
    public String login() {
        return "User/login";
    }
}
