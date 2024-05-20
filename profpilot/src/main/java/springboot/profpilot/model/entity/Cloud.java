package springboot.profpilot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Cloud {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long storageVolume;
    private Long allowedStorageVolume;
    private String location;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Member Professor;
}
