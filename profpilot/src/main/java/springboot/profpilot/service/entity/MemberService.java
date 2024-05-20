package springboot.profpilot.service.entity;


import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import springboot.profpilot.controller.Utils.GenerateRandomValue;
import springboot.profpilot.model.entity.Member;
import springboot.profpilot.model.instance.EmailVerfiy;
import springboot.profpilot.repository.entity.MemberRepository;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import springboot.profpilot.service.instance.EmailVerfiyService;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailVerfiyService emailVerfiyService;

    public Member findByEmail(String email) {
        return memberRepository.findByEmail(email);
    }

    public Member save(String university, String email, String emailDomain, String name,
                       Long studentId, String major, String password, String role) {
        Member member = new Member();
        member.setUniversity(university);
        member.setEmail(email + "@" + emailDomain);
        member.setName(name);
        member.setStudentId(studentId);
        member.setMajor(major);
        member.setPassword(passwordEncoder.encode(password));
        member.setRole(role);
        member.setStatus("ACTIVE");
        member.setCreate_at(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        member.setAgree_at(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        return memberRepository.save(member);
    }
    public String verifyEmail(String email) {
        GenerateRandomValue generateRandomValue = new GenerateRandomValue();
        String code = generateRandomValue.getRandomPassword(10);

        EmailVerfiy emailVerfiy = new EmailVerfiy();
        emailVerfiy.setEmail(email);
        emailVerfiy.setCode(code);
        emailVerfiy.setTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        emailVerfiy.setVerified(false);
        emailVerfiyService.save(emailVerfiy);

        return EmailService.sendEmailVerifyCode(email, code);
     }

    public String checkEmailVerifyCode(String email, String code) {
        EmailVerfiy emailVerfiy = emailVerfiyService.findByEmail(email);
        if (emailVerfiy.getCode().equals(code)) {
            emailVerfiy.setVerified(true);
            emailVerfiyService.save(emailVerfiy);
            return "success";
        } else {
            return "fail";
        }
    }

}
