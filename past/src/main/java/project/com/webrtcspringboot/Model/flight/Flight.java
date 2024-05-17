package project.com.webrtcspringboot.Model.flight;


// lecture는 그 과목의 전체적인 개요를 나타내는 것이다.
// flight는 그 과목이 한 번 수업할 때 생성되는 객체로 하나의 수업을 나타낸다.

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.attendance.Attendance;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
public class Flight {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String identify;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String building;

    @Column(nullable = false)
    private String Room;

    @Column(nullable = false)
    private String today;

    @Column(nullable = false)
    private String lectureDay;

    @Column(nullable = false)
    private String startTime;

    @Column(nullable = false)
    private String endTime;

    @Column(nullable = false)
    private ArrayList<String> files;

    @ManyToOne
    @JoinColumn(name = "pilot_id", nullable = false)
    private Users pilot; // professor

    @ManyToOne
    private Lecture lecture;

    @OneToMany(mappedBy = "flight", cascade = CascadeType.REMOVE)
    private List<Attendance> attendances;
}
