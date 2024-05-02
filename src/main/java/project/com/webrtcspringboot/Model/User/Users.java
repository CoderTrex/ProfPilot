package project.com.webrtcspringboot.Model.User;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Controller;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.attendance.Attendance;
import project.com.webrtcspringboot.Model.flight.Flight;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String identifier;

    @Email
    @Column(unique = true)
    private String email;

//    @Column(nullable = false)
//    private String realName;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role;

    @Column(nullable = false)
    private String status;

    @OneToMany(mappedBy = "pilot", cascade = CascadeType.REMOVE)
    @JsonBackReference
    private List<Flight> flights;

    @ManyToMany(mappedBy = "users", cascade = CascadeType.REMOVE)
    @JsonBackReference
    private List<Lecture> lectures;

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    @JsonBackReference
    private List<Attendance> attendances;
}