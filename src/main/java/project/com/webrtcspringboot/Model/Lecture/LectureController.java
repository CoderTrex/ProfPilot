package project.com.webrtcspringboot.Model.Lecture;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.http.MediaType;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import project.com.webrtcspringboot.FileUploadController;
import project.com.webrtcspringboot.storage.StorageService;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.User.UserRepository;
import project.com.webrtcspringboot.Model.flight.Flight;
import project.com.webrtcspringboot.Model.flight.FlightService;
import project.com.webrtcspringboot.Model.flight.FlightRepository;
import project.com.webrtcspringboot.Model.attendance.Attendance;
import project.com.webrtcspringboot.Model.attendance.AttendanceRepository;
import project.com.webrtcspringboot.Model.DTO.RequestSendToFlaskDTO;
import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.stream.Collectors;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;

@Controller
@RequiredArgsConstructor
@RequestMapping("/lecture")
public class LectureController {
    private final LectureService lectureService;
    private final LectureRepository lectureRepository;
    private final UserRepository UserRepository;
    private final FlightRepository flightRepository;
    private final FlightService flightService;
    private final StorageService storageService;
    private final ObjectMapper objectMapper;
    private final AttendanceRepository AttendanceRepository;
    @GetMapping("/list")
    public String list(Model model, Principal principal) {
        String username = principal.getName();
        Users user = this.UserRepository.findByName(username);
        Long userId = user.getId();
        List<Lecture> lectureList = this.lectureRepository.findAllByUserId(userId);
        model.addAttribute("userRole", user.getRole());
        model.addAttribute("lectureList", lectureList);
        return "lecture/lecture_list";
    }
    @GetMapping("/create")
    public String create(LectureForm lectureForm) {
        return "lecture/lecture_create";
    }
    @PostMapping("/create")
    public String create(@Valid LectureForm lectureForm, BindingResult bindingResult, Principal principal) {
        if (bindingResult.hasErrors()) {
            return "lecture/lecture_create";
        }
        this.lectureService.create(lectureForm.getLectureName(), lectureForm.getLectureBuilding(),
                                lectureForm.getLectureRoom(), lectureForm.getLectureDay(),
                                lectureForm.getLectureStartTime(), lectureForm.getLectureEndTime(), principal);
        return "redirect:/lecture/list";
    }
    @GetMapping("/enter")
    public String enter(@RequestParam("id") Long id, @RequestParam("lectureName") String lectureName, Model model, Principal principal) {
        Users user = this.UserRepository.findByName(principal.getName());
        Lecture lecture = this.lectureRepository.findById(id).get();
        model.addAttribute("lecture", lecture);
        ArrayList<Flight> flightList = this.flightRepository.findByLectId(id);
        model.addAttribute("flightList", flightList);
        return "lecture/lecture_detail";
    }
    @GetMapping("/room.html")
    public String room(@RequestParam("room") String roomName, Model model) {
        model.addAttribute("roomName", roomName);
        return "webrtc/room";
    }
    @GetMapping("/list/search/{lectureName}")
    public @ResponseBody List<Lecture> search(@PathVariable String lectureName) {
        return this.lectureRepository.findByKeyword(lectureName);
    }
    @PostMapping("/add/{lectureId}")
    public @ResponseBody String add(@PathVariable Long lectureId, Principal principal) {
        this.lectureService.addUser(lectureId, principal);
        return "강의 추가 완료";
    }
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id, Principal principal) {
        this.lectureService.deleteUser(id, principal);
        return "redirect:/lecture/list";
    }
    @GetMapping("/start")
    public String start(@RequestParam("id") Long id, Model model, Principal principal) throws JsonProcessingException {
        Lecture lecture = this.lectureRepository.findById(id).get();
        model.addAttribute("lecture", lecture);
        Users user = this.UserRepository.findByName(principal.getName());
        

        // 단순히 날짜만 같은거 가져오면 안됨. 강의 id도 같아야함. -> 여기
        // Flight flight = this.flightRepository.findByToday(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        Flight flight = this.flightRepository.findByTodayAndLectId(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), lecture.getId());

        if (flight == null){
            flightService.createFlight(lecture.getId(), lecture.getName(), lecture.getBuilding(),
                    lecture.getRoom(), lecture.getLectureDay(), lecture.getStartTime(), lecture.getEndTime(), principal);
            
            // 수정해야함.
            // flight = this.flightRepository.findByToday(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            flight = this.flightRepository.findByTodayAndLectId(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), lecture.getId());
        }
        String prof_name = flight.getPilot().getName();
        model.addAttribute("flight", flight);
        model.addAttribute("user", user);
        Flight finalFlight = flight;
        model.addAttribute("files", storageService.loadAll(finalFlight.getId(), prof_name).map(
                        path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                                "serveFile", path.getFileName().toString(), finalFlight.getId()).build().toUri().toString())
                .collect(Collectors.toList()));

        ArrayList<Attendance> attendanceList = this.AttendanceRepository.findByTodayAndFlight(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), flight);
        if (attendanceList.size() > 0) {
            System.out.println("출석 테이블이 이미 존재합니다.");
            return "flight/flight_detail";
        }
        else {
            RestTemplate restTemplate = new RestTemplate();
            RequestSendToFlaskDTO requestSendToFlaskDTO = new RequestSendToFlaskDTO(lecture.getName(), lecture.getId(), flight.getId());
            String url = "http://localhost:5000/lecture_attendance_create";
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            Map<String, String> param = new HashMap<>();
            param.put("lecture_name", lecture.getName());
            param.put("lecture_id", lecture.getId().toString());
            param.put("flight_id", flight.getId().toString());
            try {
                String paramJson = objectMapper.writeValueAsString(param);
                HttpEntity<String> entity = new HttpEntity<>(paramJson, headers);
                String response = restTemplate.postForObject(url, entity, String.class);
                System.out.println("flask response: " + response);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            return "flight/flight_detail";
        }

    }
}