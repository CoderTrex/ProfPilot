package project.com.webrtcspringboot.Model.flight;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.ArrayList;

public interface FlightRepository extends JpaRepository<Flight, Long> {

    @Query("SELECT a FROM Flight a WHERE a.lecture.id = ?1")
    ArrayList<Flight> findByLectId(Long id);
}
