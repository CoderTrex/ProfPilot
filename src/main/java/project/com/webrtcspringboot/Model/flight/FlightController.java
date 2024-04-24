package project.com.webrtcspringboot.Model.flight;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import project.com.webrtcspringboot.FileUploadController;
import project.com.webrtcspringboot.storage.StorageService;


import java.nio.file.Path;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Controller
@RequiredArgsConstructor
@RequestMapping("/flight")
public class FlightController {
    private final FlightRepository flightRepository;
    private final StorageService storageService;
    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Flight flight = this.flightRepository.findById(id).orElseThrow();
        String prof_name = flight.getPilot().getName();
        model.addAttribute("flight", flight);

//        http://localhost:8080/upload/files/17.sql(serveFile 방식은 잘못됨) 해당 방식이 아닌 http://localhost:8080/database/prof_name/id/17.sql 방식으로 변경해야함.
        model.addAttribute("files", storageService.loadAll(id, prof_name).map(
                path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                        "serveFile", path.getFileName().toString(), id).build().toUri().toString())
                .collect(Collectors.toList()));
        return "flight/flight_detail";
    }
}
