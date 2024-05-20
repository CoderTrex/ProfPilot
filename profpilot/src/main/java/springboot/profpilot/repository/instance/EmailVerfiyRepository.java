package springboot.profpilot.repository.instance;

import org.springframework.data.jpa.repository.JpaRepository;
import springboot.profpilot.model.instance.EmailVerfiy;

public interface EmailVerfiyRepository extends JpaRepository<EmailVerfiy, Long> {
    EmailVerfiy findByEmail(String email);
    void deleteByEmail(String email);
}
