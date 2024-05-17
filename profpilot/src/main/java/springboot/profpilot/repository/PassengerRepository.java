package springboot.profpilot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import springboot.profpilot.model.Passenger;

import java.util.Optional;

public interface PassengerRepository extends JpaRepository<Passenger, Long> {
    Optional<Passenger> findByEmail(String email);
}
