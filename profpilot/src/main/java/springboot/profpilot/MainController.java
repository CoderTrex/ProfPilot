package springboot.profpilot;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.member.MemberService;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final MemberService memberService;

    @GetMapping("/")
    public String main(Principal principal) {
        if (principal == null) {
            return "redirect:/user/login";
        }
        return "redirect:/main/main_page";
    }

    @GetMapping("/main/main_page")
    public String mainPage(Model model, Principal principal) {
        // main 화면 todo list
        // 1. 오늘 수업 목록
        Member member = memberService.findByEmail(principal.getName());
        model.addAttribute("member", member);
        return "main/main_page";
    }
}
