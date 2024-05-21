package springboot.profpilot.model.emailverfiy;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface EmailVerfiyRepository extends JpaRepository<EmailVerfiy, Long> {
    EmailVerfiy findByEmail(String email);

    @Modifying
    @Transactional
    @Query("delete from EmailVerfiy e where e.email = ?1")
    void deleteByEmail(String email);
}

