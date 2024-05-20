package springboot.profpilot.controller.userController;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import springboot.profpilot.model.entity.Member;
import springboot.profpilot.model.instance.EmailVerfiy;
import springboot.profpilot.service.entity.MemberService;
import springboot.profpilot.service.instance.EmailVerfiyService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final MemberService memberService;
    private final EmailVerfiyService emailVerfiyService;


    @Getter
    @Setter
    class SignupForm {
        @NotEmpty(message = "대학교를 입력해주세요.")
        private String university;
        @NotEmpty(message = "이메일을 입력해주세요.")
        private String email;
        @NotEmpty(message = "이메일 도메인을 입력해주세요.")
        private String emailDomain;
        @NotEmpty(message = "이름을 입력해주세요.")
        private String name;
        @NotEmpty(message = "학번을 입력해주세요.")
        private Long studentId;
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
        memberService.save(signupForm.getUniversity(), signupForm.getEmail(), signupForm.getEmailDomain(),
                signupForm.getName(), signupForm.getStudentId(),
                signupForm.getMajor(), signupForm.getPassword(), signupForm.getRole());
        return "redirect:/user/login";
    }

    @PostMapping("/signup/email/verify")
    public @ResponseBody String verifyEmail(@RequestParam("email") String email) {
        EmailVerfiy emailVerfiy = emailVerfiyService.findByEmail(email);

        if (emailVerfiy != null) {
            String sendTime = emailVerfiy.getTime();
            if (emailVerfiy.isVerified()) {
                return "already";
            }
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime sendTimeParsed = LocalDateTime.parse(sendTime, formatter);
            LocalDateTime now = LocalDateTime.now();
            String nowString = now.format(formatter);
            LocalDateTime nowParsed = LocalDateTime.parse(nowString, formatter);
            if (nowParsed.isBefore(sendTimeParsed.plusMinutes(5))) {
                return "wait";
            }
            else {
                emailVerfiyService.deleteByEmail(email);
            }
        }

        String response = memberService.verifyEmail(email);
        if (response.equals("success")) {
            return "success";
        } else {
            return "fail";
        }
    }

    @GetMapping("/signup/email/verify")
    public @ResponseBody String verifyEmail(@RequestParam("email") String email, @RequestParam("code") String code) {
        String response = memberService.checkEmailVerifyCode(email, code);

        if (response.equals("success")) {
            return "success";
        } else {
            return "fail";
        }
    }

    @GetMapping("/login")
    public String login() {
        return "user/login";
    }

}
