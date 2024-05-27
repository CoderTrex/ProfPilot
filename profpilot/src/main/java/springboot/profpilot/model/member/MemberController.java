package springboot.profpilot.model.member;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import springboot.profpilot.model.DTO.CheckEmail;
import springboot.profpilot.model.DTO.SignUpDTO;
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


    @GetMapping("/test")
    public @ResponseBody String test() {
        System.out.println("test");
        return "test";
    }


    // 이메일, 비밀번호, 이름, 학번만 받아서 회원가입
    @PostMapping("/signup")
    public @ResponseBody String signup(@RequestBody SignUpDTO member) {
        if (member.getEmail() == null || member.getPassword() == null || member.getName() == null || member.getStudentId() == null) {
            return "lack";
        }
        if (memberService.findByEmail(member.getEmail()) != null) {
            return "already";
        }
        EmailVerfiy emailVerfiy = emailVerfiyService.findByEmail(member.getEmail());
        if (emailVerfiy == null || !emailVerfiy.isVerified()) {
            return "not-Verified";
        }
        memberService.save(member.getEmail(), member.getPassword(), member.getName(), member.getStudentId());
        return "success";
    }

    @PostMapping("/signup/email/verify")
    public @ResponseBody String verifyEmail(@RequestBody String json_email) {
        String email = json_email.substring(10, json_email.length() - 2);
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
    public @ResponseBody String checkEmail(@RequestBody CheckEmail checkEmail) {
        String email = checkEmail.getEmail();
        String code = checkEmail.getVerifyCode();
        return memberService.checkEmailVerifyCode(email, code);
    }

    @GetMapping("/login")
    public String login() {
        System.out.println("login page");
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
