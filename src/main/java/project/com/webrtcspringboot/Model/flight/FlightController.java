package project.com.webrtcspringboot.Model.flight;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import project.com.webrtcspringboot.Model.flight.FlightRepository;

@Controller
@RequiredArgsConstructor
@RequestMapping("/flight")
public class FlightController {
    private final FlightRepository flightRepository;
    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Flight flight = this.flightRepository.findById(id).orElseThrow();
        model.addAttribute("flight", flight);
        return "flight/flight_detail";
    }
}
