package springboot.profpilot.service.instance;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import springboot.profpilot.repository.instance.EmailVerfiyRepository;
import springboot.profpilot.model.instance.EmailVerfiy;

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
    public void deleteByEmail(String email) {
        emailVerfiyRepository.deleteByEmail(email);
    }
}
