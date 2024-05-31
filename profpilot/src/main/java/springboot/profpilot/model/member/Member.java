package springboot.profpilot.model.member;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import springboot.profpilot.model.AuthApply.AuthApply;
import springboot.profpilot.model.attendance.Attendance;
import springboot.profpilot.model.flight.Flight;
import springboot.profpilot.model.lecture.Lecture;
import springboot.profpilot.model.notification.Notification;

import java.util.List;

@Getter
@Setter
@Entity
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String email;

    private String university;
    private String name;
    private Long studentId;
    private String major;
    private String phone;
    private String membership;
    private String membershipExpire;
    private String password;
    private String role;
    private String status;
    private String create_at;
    private String agree_at;

    private Boolean AccountNonExpired;
    private Boolean AccountNonLocked;
    private Boolean CredentialsNonExpired;
    private Boolean Enabled;

    @ManyToMany(cascade = CascadeType.ALL)
    @JsonBackReference
    private List<Lecture> lectures;

    @ManyToMany(cascade = CascadeType.ALL)
    @JsonBackReference
    private List<Flight> flights;

    @ManyToMany(cascade = CascadeType.ALL)
    @JsonBackReference
    private List<Attendance> attendances;

    @ManyToMany(cascade = CascadeType.ALL)
    @JsonBackReference
    private List<Notification> notifications;

    @OneToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private AuthApply authApply;
}
