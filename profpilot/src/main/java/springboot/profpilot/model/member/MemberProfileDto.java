package springboot.profpilot.model.member;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class MemberProfileDto {
//    이름, 학번, 이메일
//    구매등급, 권한 만료일, 현재 역할(student or professor)
//    클라우드 등급, 클라우드 사용량, 클라우드 허용용량

    private String name;
    private Long studentId;
    private String email;
    private String purchaseGrade;
    private LocalDate authorityExpirationDate;
    private String role;
    private String cloudGrade;
    private String cloudUsage;
    private String cloudAllowance;

    // 생성자, getter, setter
}
