package project.com.webrtcspringboot.Model.flight;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.User.UserRepository;
import project.com.webrtcspringboot.Model.Lecture.LectureRepository;
import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

@RequiredArgsConstructor
@Service
public class FlightService {
    private final UserRepository UserRepository;
    private final FlightRepository flightRepository;
    private final LectureRepository lectureRepository;
    public void createFlight(Long lectureId, String lectureName, String lectureBuilding,
                             String lectureRoom, String lectureDay, String lectureStartTime,
                             String lectureEndTime, Principal principal) {
        Users user = this.UserRepository.findByEmail(principal.getName());
        Lecture lecture = this.lectureRepository.findById(lectureId).orElseThrow();
        Flight flight = new Flight();
        flight.setIdentify(lectureId + "_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
        flight.setName(lectureName);
        flight.setBuilding(lectureBuilding);
        flight.setRoom(lectureRoom);
        flight.setToday(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        flight.setLectureDay(lectureDay);
        flight.setStartTime(lectureStartTime);
        flight.setEndTime(lectureEndTime);
        flight.setFiles(new ArrayList<>());
        flight.setLecture(lecture);
        flight.setPilot(user);
        this.flightRepository.save(flight);
    }
}
