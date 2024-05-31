package springboot.profpilot.model.AuthApply;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import springboot.profpilot.model.member.Member;

@Entity
@Getter
@Setter
public class AuthApply {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    private Member applicant;

    private String applicantUniversity;
    private String approvedUniversity;
    private String applyDate;
    private String isPermitted;

}
