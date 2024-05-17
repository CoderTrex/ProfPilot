package project.com.webrtcspringboot.Controller.api;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
@RequiredArgsConstructor
@Controller
@RequestMapping("/api")
public class APIController {
    private final BuildingRepository buildingRepository;
//    /api/buildings/1
    @GetMapping("/buildings")
    public @ResponseBody List<Building> getBuildings(@RequestParam Long universityId) {
        return buildingRepository.findByUniversityId(universityId);
    }
}
