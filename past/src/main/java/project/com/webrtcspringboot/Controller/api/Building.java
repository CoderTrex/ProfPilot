package project.com.webrtcspringboot.Controller.api;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.GenerationType;
import lombok.Getter;
import lombok.Setter;


@Entity
@Getter
@Setter
public class Building {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long universityId;
    private String buildingName;
    private String buildingLat;
    private String buildingLon;
    private String buildingAllowedDistance;
}