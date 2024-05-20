package springboot.profpilot.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
@Entity
public class Lecture {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Column(unique = true)
    private Long identifier;

    private String date;
    private String time;
    private String building;
    private String password;
    private String start_time;
    private String end_time;
    private Long attendance_rate;
    private String materials;

    @ManyToMany(cascade = CascadeType.ALL)
    private List<Member> Students;

    @ManyToMany(cascade = CascadeType.ALL)
    private List<Attendance> attendances;

    @ManyToMany(cascade = CascadeType.ALL)
    private List<Notification> notifications;

    @ManyToMany(cascade = CascadeType.ALL)
    private List<Flight> flights;

    @ManyToOne(cascade = CascadeType.ALL)
    private Member Professor;
}

