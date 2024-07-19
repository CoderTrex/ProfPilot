package project.com.webrtcspringboot.Model.flight;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public interface FlightRepository extends JpaRepository<Flight, Long> {
    @Query("SELECT a FROM Flight a WHERE a.lecture.id = ?1")
    ArrayList<Flight> findByLectId(Long id);
    @Query("SELECT a FROM Flight a WHERE a.today = ?1")
    Flight findByToday(String today);
    @Query("SELECT a FROM Flight a WHERE a.today = ?1 AND a.lecture.id = ?2")
    Flight findByTodayAndLectId(String today, Long id);
}
