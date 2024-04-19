package project.com.webrtcspringboot.Model.attendance;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.flight.Flight;

@Setter
@Getter
@Entity
public class Attendance {
    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String date;

    @Column(nullable = false)
    private String status;

    @Column(nullable = false)
    private String lectName;

    @ManyToOne
    @JsonManagedReference
    private Users user;

    @ManyToOne
    @JsonManagedReference
    private Flight flight;
}
