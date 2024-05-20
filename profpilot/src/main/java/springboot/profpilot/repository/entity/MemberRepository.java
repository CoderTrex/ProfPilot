package springboot.profpilot.repository.entity;

import org.springframework.data.jpa.repository.JpaRepository;
import springboot.profpilot.model.entity.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Member findByEmail(String email);
}
