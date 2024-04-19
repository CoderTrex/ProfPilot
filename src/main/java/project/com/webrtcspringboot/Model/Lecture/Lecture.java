package project.com.webrtcspringboot.Model.Lecture;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import project.com.webrtcspringboot.Model.User.Users;
import java.util.List;
import project.com.webrtcspringboot.Model.flight.Flight;


@Getter
@Setter
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
    private String lectureDay;

    @Column(nullable = false)
    private String startTime;

    @Column(nullable = false)
    private String endTime;

    @ManyToOne
    @JsonManagedReference
    private Users professor;

    @ManyToMany(cascade = CascadeType.REMOVE)
    @JsonManagedReference
    private List<Users> users;

    @OneToMany(mappedBy = "lecture", cascade = CascadeType.REMOVE)
    @JsonBackReference
    private List<Flight> flights;
    public Lecture() {
    }
}