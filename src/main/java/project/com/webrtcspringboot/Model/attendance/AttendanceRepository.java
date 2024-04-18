package project.com.webrtcspringboot.Model.attendance;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.ArrayList;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    Attendance findByUserId(Long id);
    Attendance findByLectName(String name);


//    ArrayList<Attendance> attendance = this.attendanceRepository.findByLectNameAndUserId(lectureName, user.getId());
    @Query("SELECT a FROM Attendance a WHERE a.lectName = ?1 AND a.userId = ?2")
    ArrayList<Attendance> findByLectNameAndUserId(String lectName, Long userId);
}
