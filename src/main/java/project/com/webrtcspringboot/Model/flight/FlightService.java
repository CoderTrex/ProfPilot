package project.com.webrtcspringboot.Model.flight;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@RequiredArgsConstructor
@Service
public class FlightService {
//this.flightService.createFlight(lectureForm.getLectureName(), lectureForm.getLectureRoom(), lectureForm.getLectureDay(),
//        lectureForm.getLectureStartTime(), lectureForm.getLectureEndTime(), principal);

    // 16주차로 구성됨. 각 주차에는 2개의 강의가 있음.
    public void createFlight(String lectureName, String lectureRoom, String lectureDay, String lectureStartTime, String lectureEndTime, Principal principal) {
//        Flight flight = new Flight();
//        flight.setLectureName(lectureName);
//        flight.setLectureRoom(lectureRoom);
//        flight.setLectureDay(lectureDay);
//        flight.setLectureStartTime(lectureStartTime);
//        flight.setLectureEndTime(lectureEndTime);
//        flight.setUser(this.UserRepository.findByName(principal.getName()));
//        this.flightRepository.save(flight);
    }
}
