package project.com.webrtcspringboot.Model.attendance;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.flight.Flight;
import project.com.webrtcspringboot.Model.flight.FlightRepository;
import project.com.webrtcspringboot.Model.User.UserRepository;

import java.security.Principal;
import java.util.List;
import java.util.Objects;

@Controller
@RequiredArgsConstructor
@RequestMapping("/attendance")
public class AttendanceController {
    private final AttendanceRepository attendanceRepository;
    private final AttendanceService attendanceService;
    private final FlightRepository flightRepository;
    private final UserRepository userRepository;


    @PostMapping("/prof/click/{status}/{id}/{Flight}")
    public String profClickAttend(@PathVariable("status") String status, @PathVariable("attendanceId") Long id, @PathVariable("flightId") Flight flight, Principal principal, Model model) {
        Users user = userRepository.findByName(principal.getName());
        if (!Objects.equals(user.getRole(), "prof")) {
            return "redirect:/";
        }
        String date = flight.getToday().formatted("%YYYY-%MM-%DD");
        List<Attendance> attendances = attendanceRepository.findByTodayAndFlight(date, flight);
        model.addAttribute("attendanceList", attendances);
        model.addAttribute("flight", flight);

        Attendance attendance = this.attendanceRepository.findById(id).orElseThrow();
        attendance.setStatus(status);
        this.attendanceRepository.save(attendance);
        return "flight/flight_attendance_detail";
    }

}

