package springboot.profpilot.model.member;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {
    private final MemberService memberService;

    @GetMapping("/profile/myinfo")
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
