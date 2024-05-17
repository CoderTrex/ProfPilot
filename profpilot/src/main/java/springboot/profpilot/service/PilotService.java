package springboot.profpilot.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import springboot.profpilot.controller.Utils.GenerateRandomValue;
import springboot.profpilot.model.Pilot;
import springboot.profpilot.repository.PilotRepository;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
public class PilotService {
    private final PilotRepository pilotRepository;
    private final CloudService cloudService;
    private final GenerateRandomValue generateRandomValue;

    public void save(String name, String email, String major, String phone, String password)
    {
        Pilot pilot = new Pilot();
        pilot.setName(name);
        pilot.setEmail(email);
        pilot.setMajor(major);
        pilot.setPhone(phone);
        pilot.setPassword(password);
        pilot.setRole("ROLE_USER");
        pilot.setStatus("ACTIVE");
        pilot.setPurchase_grade("NONE");
        pilot.setPurchase_grade_duration("NONE");
        pilot.setCloud(email);
        pilot.setCreate_at(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        pilotRepository.save(pilot);
        cloudService.generateCloud(email, pilot);
    }
}
