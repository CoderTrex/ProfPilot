package springboot.profpilot.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
@Entity
public class Passenger {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String email;

    private String name;
    private String major;
    private String phone;
    private String backup_email;
    private String password;
    private String role;
    private String status;
    private Long grade;
    private String create_at;

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
}
