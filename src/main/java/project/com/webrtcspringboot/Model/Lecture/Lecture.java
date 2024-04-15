package project.com.webrtcspringboot.Model.Lecture;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import project.com.webrtcspringboot.Model.User.Users;
import java.util.List;


@Setter
@Getter
@Entity
public class Lecture {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String Room;

    @Column(nullable = false)
    private String startTime;

    @Column(nullable = false)
    private String endTime;

    @ManyToMany
    private List<Users> users;

    public Lecture() {
    }
}