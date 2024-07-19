package springboot.profpilot.model.AuthApply;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import springboot.profpilot.model.member.Member;

@Entity
@Getter
@Setter
public class AuthApply {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @Cascade(CascadeType.ALL)
    private Member applicant;

    private String applicantUniversity;
    private String approvedUniversity;
    private String applyDate;
    private String isPermitted;

}
