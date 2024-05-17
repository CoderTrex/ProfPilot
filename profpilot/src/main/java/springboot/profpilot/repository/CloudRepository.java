package springboot.profpilot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import springboot.profpilot.model.Cloud;

public interface CloudRepository extends JpaRepository<Cloud, Long> {
}
