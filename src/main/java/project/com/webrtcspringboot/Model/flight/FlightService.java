package project.com.webrtcspringboot.Model.flight;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.User.UserRepository;
import project.com.webrtcspringboot.Model.Lecture.LectureRepository;
import java.security.Principal;
import java.util.ArrayList;

@RequiredArgsConstructor
@Service
public class FlightService {
    private final UserRepository UserRepository;
    private final FlightRepository flightRepository;
    private final LectureRepository lectureRepository;
    public void createFlight(Long lectureId, String lectureName, String lectureBuilding,
                             String lectureRoom, String lectureDay, String lectureStartTime,
                             String lectureEndTime, int week, int ordinal, Principal principal) {
        Users user = this.UserRepository.findByName(principal.getName());
        Lecture lecture = this.lectureRepository.findById(lectureId).orElseThrow();
        Flight flight = new Flight();
        flight.setName(lectureName);
        flight.setBuilding(lectureBuilding);
        flight.setRoom(lectureRoom);
        flight.setWeek(week);
        flight.setOrdinal(ordinal);
        flight.setLectureDay(lectureDay);
        flight.setStartTime(lectureStartTime);
        flight.setEndTime(lectureEndTime);
        flight.setFiles(new ArrayList<>());
        flight.setLecture(lecture);
        flight.setPilot(user);
        this.flightRepository.save(flight);
    }
}
