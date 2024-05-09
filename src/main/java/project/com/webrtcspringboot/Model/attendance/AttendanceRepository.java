package project.com.webrtcspringboot.Model.attendance;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.flight.Flight;

import java.util.ArrayList;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    Attendance findByUserId(Long id);
    Attendance findByLectName(String name);


    @Query("SELECT a FROM Attendance a WHERE a.lectName = ?1 AND a.user = ?2")
    ArrayList<Attendance> findByLectNameAndUserId(String lectName, Users user);

    @Query("SELECT a FROM Attendance a WHERE a.date = ?1 AND a.flight = ?2")
    ArrayList<Attendance> findByTodayAndFlight(String today, Flight flight);

    @Query("SELECT a FROM Attendance a WHERE a.lectName = ?1 AND a.flight = ?2 AND a.user = ?3")
    Attendance findByLectNameAndFlightAndUser(String lectName, Flight flight, Users user);

    @Query("SELECT a FROM Attendance a WHERE a.lectName = ?1 AND a.flight = ?2")
    ArrayList<Attendance> findByLectNameAndFlight(String lectName, Flight flight);

    @Query("SELECT a FROM Attendance a WHERE a.user = ?1 AND a.date = ?2")
    Attendance findByUserAndToday(Users user, String today);

}
