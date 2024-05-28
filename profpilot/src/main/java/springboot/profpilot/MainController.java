package springboot.profpilot;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.member.MemberService;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final MemberService memberService;

    @GetMapping("/")
    @ResponseBody
    public String main(Principal principal) {
        System.out.println("main page");
        if (principal == null) {
            return "fail to login";
//            return "redirect:/member/login";
        }
        return "success";
//        return "redirect:/main/main_page";
    }

    @GetMapping("/main/main_page")
    public String mainPage(Model model, Principal principal) {
        // main 화면 todo list
        // 1. 오늘 수업 목록
        Member member = memberService.findByEmail(principal.getName());
        model.addAttribute("member", member);
        return "main/main_page";
    }
    @GetMapping("/sendToken/{token}")
    @ResponseBody
    public Map<String, String> sendToken(@PathVariable String token, HttpServletResponse res) {

        res.addCookie(new Cookie("aaa", "aaa"));
        Map<String, String> response = new HashMap<>();
        response.put("token", token);
        return response;
    }
}
