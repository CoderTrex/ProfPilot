package springboot.profpilot.controller.userController;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import springboot.profpilot.repository.PassengerRepository;
import springboot.profpilot.service.PassengerService;
import springboot.profpilot.service.PilotService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
    private final PassengerService passengerService;
    private final PilotService pilotService;

    @Getter
    @Setter
    class SignupForm {
        @NotEmpty(message = "이메일을 입력해주세요.")
        private String email;
        @NotEmpty(message = "이름을 입력해주세요.")
        private String name;
        @NotEmpty(message = "학번을 입력해주세요.")
        private String studentId;
        @NotEmpty(message = "전공을 입력해주세요.")
        private String major;
        @NotEmpty(message = "비밀번호를 입력해주세요.")
        private String password;
        @NotEmpty(message = "교수 또는 학생을 선택해주세요.")
        private String role;
    }
    @GetMapping("/signup")
    public String signup(SignupForm signupForm) {
        return "user/signup";
    }

    @PostMapping("/signup")
    public String signup(@Valid SignupForm signupForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "user/signup";
        }
        if (signupForm.getRole().equals("professor")) {
            pilotService.save(signupForm.getEmail(), signupForm.getName(), signupForm.getStudentId(), signupForm.getMajor(), signupForm.getPassword());
        } else {
            passengerService.save(signupForm.getEmail(), signupForm.getName(), signupForm.getStudentId(), signupForm.getMajor(), signupForm.getPassword());
        }

        return "redirect:/user/login";
    }

    @GetMapping("/login")
    public String login() {
        return "user/login";
    }

}
