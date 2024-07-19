package springboot.profpilot.model.attendance;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.CascadeType;
import jakarta.persistence.ManyToOne;
import org.springframework.data.jpa.repository.JpaRepository;
import springboot.profpilot.model.lecture.Lecture;
import springboot.profpilot.model.member.Member;

import java.util.List;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {

    Attendance findByLectureAndStudentAndDate(Lecture lecture, Member student, String date);


}
