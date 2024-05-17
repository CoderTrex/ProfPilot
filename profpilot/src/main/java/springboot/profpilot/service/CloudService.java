package springboot.profpilot.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import springboot.profpilot.controller.Utils.GenerateRandomValue;
import springboot.profpilot.model.Cloud;
import springboot.profpilot.model.Pilot;
import springboot.profpilot.repository.CloudRepository;

@Service
@RequiredArgsConstructor
public class CloudService {
    private final CloudRepository cloudRepository;

    public void generateCloud(String email, Pilot pilot) {
        Cloud cloud = new Cloud();
        cloud.setStorageVolume(0L);
        cloud.setAllowedStorageVolume(20L);
        cloud.setLocation(email);
        cloud.setPilot(pilot);

    }
}
