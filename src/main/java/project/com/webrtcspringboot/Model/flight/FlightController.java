package project.com.webrtcspringboot.Model.flight;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import project.com.webrtcspringboot.FileUploadController;
import project.com.webrtcspringboot.Model.attendance.Attendance;
import project.com.webrtcspringboot.Model.attendance.AttendanceRepository;
import project.com.webrtcspringboot.storage.StorageService;


import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
@RequestMapping("/flight")
public class FlightController {
    private final FlightRepository flightRepository;
    private final StorageService storageService;
    private final AttendanceRepository attendanceRepository;

    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Flight flight = this.flightRepository.findById(id).orElseThrow();
        String prof_name = flight.getPilot().getName();
        model.addAttribute("flight", flight);

        model.addAttribute("files", storageService.loadAll(id, prof_name).map(
                path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                        "serveFile", path.getFileName().toString(), id).build().toUri().toString())
                .collect(Collectors.toList()));
        return "flight/flight_detail";
    }

    @GetMapping("/attendance/detail")
    public String getFlightAttendanceDetail(@RequestParam("id") Long id, @RequestParam("date") String date, Model model) {
        Flight flight = this.flightRepository.findById(id).orElseThrow();
        List<Attendance> attendances = attendanceRepository.findByTodayAndFlight(date, flight);
        model.addAttribute("attendanceList", attendances);
        model.addAttribute("flight", flight);
        return "flight/flight_attendance_detail";
    }
}

