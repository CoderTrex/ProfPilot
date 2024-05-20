package springboot.profpilot.model.entity;


import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Attendance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String status;
    private String time;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Member Student;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Flight flight;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Lecture lecture;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Notification notification;
}