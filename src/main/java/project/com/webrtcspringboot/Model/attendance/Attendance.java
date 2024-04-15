package project.com.webrtcspringboot.Model.attendance;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.User.Users;

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
    private Long userId;

    @Column(nullable = false)
    private String lectName;
    public Attendance() {
    }
}
