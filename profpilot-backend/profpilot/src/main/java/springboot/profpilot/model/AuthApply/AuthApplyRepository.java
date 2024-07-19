package springboot.profpilot.model.AuthApply;

import org.springframework.data.jpa.repository.JpaRepository;
import springboot.profpilot.model.member.Member;

import java.util.List;

public interface AuthApplyRepository extends JpaRepository<AuthApply, Long> {
   AuthApply findByApplicant(Member applicant);
}
