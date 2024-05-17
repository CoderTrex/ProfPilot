package springboot.profpilot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import springboot.profpilot.model.Pilot;

import java.util.Optional;

public interface PilotRepository extends JpaRepository<Pilot, Long> {
    Optional<Pilot> findByEmail(String email);
}
