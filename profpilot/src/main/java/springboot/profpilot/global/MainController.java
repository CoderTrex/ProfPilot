package springboot.profpilot.global;

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
import springboot.profpilot.global.Utils.MakeJsonResponse;
import springboot.profpilot.model.DTO.MainPageDTO;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.member.MemberService;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final MemberService memberService;

    @GetMapping("/sendToken/{token}")
    @ResponseBody
    public Map<String, String> sendToken(@PathVariable String token, HttpServletResponse res) {
        Map<String, String> response = new HashMap<>();
        response.put("token", token);
        return response;
    }

    @GetMapping("/main/page")
    @ResponseBody
    public Map<String, String> mainPage(Principal principal) {
        Member member = memberService.findByEmail(principal.getName());
        MainPageDTO mainPageDTO = new MainPageDTO();
        mainPageDTO.setName(member.getName());
        mainPageDTO.setRole(member.getRole());
        return MakeJsonResponse.makeJsonResponse(mainPageDTO);
    }

}
