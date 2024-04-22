package project.com.webrtcspringboot.Model.attendance;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.flight.Flight;

import java.util.ArrayList;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    Attendance findByUserId(Long id);
    Attendance findByLectName(String name);


    @Query("SELECT a FROM Attendance a WHERE a.lectName = ?1 AND a.user = ?2")
    ArrayList<Attendance> findByLectNameAndUserId(String lectName, Users user);
}
