package springboot.profpilot.model.attendance;


import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import springboot.profpilot.model.flight.Flight;
import springboot.profpilot.model.lecture.Lecture;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.notification.Notification;

import java.util.List;

@Getter
@Setter
@Entity
public class Attendance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String date;
    private String status;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Member student;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Lecture lecture;
//
//    @ManyToMany(cascade = CascadeType.ALL)
//    @JsonBackReference
//    private Notification notification;
}