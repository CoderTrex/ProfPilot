package com.example.ms1.member;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Controller;
import jakarta.validation.constraints.NotEmpty;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    @Getter
    @Setter
    class MemberForm {
        @NotEmpty(message = "이메일은 필수입니다." )
        private String email;
        @NotEmpty(message = "비밀번호는 필수입니다.")
        private String password;
        @NotEmpty(message = "닉네임은 필수입니다.")
        private String nickname;
    }

    @GetMapping("/signup")
    public String signup(MemberForm form) {
        return "signup";
    }
    @PostMapping("/signup")
    public String signup(@Valid MemberForm form, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "signup";
        }
        memberService.save(form.getEmail(), form.getPassword(), form.getNickname());
        return "redirect:/";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }
}















