package springboot.profpilot.model.DTO.page;

import springboot.profpilot.model.attendance.Attendance;
import springboot.profpilot.model.flight.Flight;

import java.util.List;

public class LecturePageDTO {
    String lectureStartTime;
    String lectureEndTime;
    List<Attendance> attendances;
}
