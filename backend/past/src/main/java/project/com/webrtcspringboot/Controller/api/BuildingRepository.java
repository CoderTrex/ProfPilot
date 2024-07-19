package project.com.webrtcspringboot.Controller.api;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BuildingRepository extends JpaRepository<Building, Long> {
    List<Building> findByUniversityId(Long universityId);
}
