package springboot.profpilot.model.emailverfiy;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailVerfiyService {
    private final EmailVerfiyRepository emailVerfiyRepository;

    public void save(EmailVerfiy emailVerfiy) {
        emailVerfiyRepository.save(emailVerfiy);
    }

    public EmailVerfiy findByEmail(String email) {
        return emailVerfiyRepository.findByEmail(email);
    }

    @Transactional
    public void deleteByEmail(String email) {
        emailVerfiyRepository.deleteByEmail(email);
    }
}
