package springboot.profpilot.model.member;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import springboot.profpilot.model.emailverfiy.EmailVerfiy;
import springboot.profpilot.model.emailverfiy.EmailVerfiyService;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {
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
        if (signupForm.getUniversity() != null && signupForm.getEmail() != null && signupForm.getEmailDomain() != null && signupForm.getName() != null && signupForm.getStudentId() != null && signupForm.getMajor() != null && signupForm.getPassword() != null && signupForm.getRole() != null) {
            if (signupForm.getUniversity().equals("") || signupForm.getEmail().equals("") || signupForm.getEmailDomain().equals("") || signupForm.getName().equals("") || signupForm.getStudentId().equals("") || signupForm.getMajor().equals("") || signupForm.getPassword().equals("") || signupForm.getRole().equals("")) {
                return "user/signup";
            }
        }
        if (memberService.findByEmail(signupForm.getEmail() + "@" + signupForm.getEmailDomain()) != null) {
            bindingResult.rejectValue("email", null, "이미 가입된 이메일입니다.");
            return "user/signup";
        }
        EmailVerfiy emailVerfiy = emailVerfiyService.findByEmail(signupForm.getEmail() + "@" + signupForm.getEmailDomain());
        if (emailVerfiy == null || !emailVerfiy.isVerified()) {
            bindingResult.rejectValue("email", null, "이메일 인증을 해주세요.");
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

    @PostMapping("/signup/email/verify/check")
    public @ResponseBody String verifyEmail(@RequestParam("email") String email, @RequestParam("code") String code) {
        System.out.println("verifyEmail");
        System.out.println("email: " + email);
        System.out.println("code: " + code);
        return memberService.checkEmailVerifyCode(email, code);
    }

    @GetMapping("/login")
    public String login() {
        return "user/login";
    }


    @GetMapping("/profile/info")
    public String GetProfile(Model model, Principal principal) {
        // myinfo 화면 todo list
        // 1. 회원 정보 자체
        // : 이메일, 대학, 이름, 학번, 전공, 핸드폰 번호, 역할, 현재 상태, 가입일
        // 2. 클라우드 저장 정보
        // : 저장 용량, 사용량, 파일 수, 최대 파일 수, 최대 파일 크기

        Member member = memberService.findByEmail(principal.getName());
        model.addAttribute("member", member);
        return "user/profile";
    }
}
