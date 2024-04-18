package project.com.webrtcspringboot.Model.User;


import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.Getter;
import lombok.Setter;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.attendance.Attendance;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Email
    @Column(unique = true)
    private String email;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role;

    @Column(nullable = false)
    private String status;

    @ManyToMany(mappedBy = "users", cascade = CascadeType.REMOVE)
    private List<Lecture> lectures;

    @OneToMany(mappedBy = "userId", cascade = CascadeType.REMOVE)
    private List<Attendance> attendances;
    public Users() {
    }
}