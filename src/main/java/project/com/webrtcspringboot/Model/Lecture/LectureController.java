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
import project.com.webrtcspringboot.Model.attendance.AttendanceService;
import project.com.webrtcspringboot.Model.attendance.AttendanceRepository;

import java.nio.charset.StandardCharsets;
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
    private final AttendanceService attendanceService;
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
        Long lectureId = this.lectureService.create(lectureForm.getLectureName(),    lectureForm.getLectureBuilding(),
                                lectureForm.getLectureRoom(),       lectureForm.getLectureDay(),
                                lectureForm.getLectureStartTime(),  lectureForm.getLectureEndTime(),
                                lectureForm.getLecturePassword(),   principal);
        this.lectureService.addProf(lectureId, principal);
        return "redirect:/lecture/list";
    }
    @GetMapping("/enter")
    public String enter(@RequestParam("id") Long id, @RequestParam("lectureName") String lectureName, Model model, Principal principal) {
        Users user = this.UserRepository.findByName(principal.getName());
        model.addAttribute("user", user);
        Lecture lecture = this.lectureRepository.findById(id).get();
        model.addAttribute("lecture", lecture);
        List<Flight> flightList = this.flightRepository.findByLectId(id);
        model.addAttribute("flightList", flightList);
        return "lecture/lecture_detail";
    }
    @GetMapping("boarding/room.html")
    public String room(@RequestParam("room") String roomName, Model model) {
        model.addAttribute("roomName", roomName);
        return "webrtc/room";
    }
    @GetMapping("/list/search/{lectureName}")
    public @ResponseBody List<Lecture> search(@PathVariable String lectureName) {
        return this.lectureRepository.findByKeyword(lectureName);
    }
    @PostMapping("/add/{lectureId}")
    public @ResponseBody String add(@PathVariable Long lectureId, @RequestParam("password") String password, Principal principal) {
        Lecture lecture = this.lectureRepository.findById(lectureId).get();
        if (!lecture.getLecturePassword().equals(password)) {
            return "{\"success\": false, \"message\": \"비밀번호가 일치하지 않습니다.\"}";
        }
        this.lectureService.addUser(lectureId, principal);
        return "{\"success\": true}";
    }
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id, Principal principal) {
        this.lectureService.deleteUser(id, principal);
        return "redirect:/lecture/list";
    }
    @GetMapping("/drop/{id}")
    public String drop(@PathVariable Long id, Principal principal) {
        this.lectureService.deleteAllUsers(id);
        this.lectureRepository.delete(this.lectureRepository.findById(id).get());
        return "redirect:/lecture/list";
    }
    @GetMapping("/make_flight") // 교수님이 강의 시작 버튼을 누르면 호출되는 함수
    public String flight(@RequestParam("id") Long id, Model model, Principal principal) throws JsonProcessingException {
        Lecture lecture = this.lectureRepository.findById(id).get();
        model.addAttribute("lecture", lecture);
        Users user = this.UserRepository.findByName(principal.getName());
        Flight flight = this.flightRepository.findByTodayAndLectId(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), lecture.getId());

        if (flight == null){
            flightService.createFlight(lecture.getId(), lecture.getName(), lecture.getBuilding(),
                    lecture.getRoom(), lecture.getLectureDay(), lecture.getStartTime(), lecture.getEndTime(), principal);
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
            return "flight/flight_detail";
        }
        else {
            RestTemplate restTemplate = new RestTemplate();
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

            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            return "flight/flight_detail";
        }

    }
    @GetMapping("/enter_flight/professor")
    public String enter_flight1(@RequestParam("id") Long id, Model model, Principal principal) {
        Users user = this.UserRepository.findByName(principal.getName());
        if (user.getRole().equals("student")) {
            return "redirect:/lecture/list";
        }
        Lecture lecture = this.lectureRepository.findById(id).get();
        model.addAttribute("lecture", lecture);
        Flight flight = this.flightRepository.findByTodayAndLectId(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), lecture.getId());
        String prof_name = flight.getPilot().getName();
        model.addAttribute("flight", flight);
        model.addAttribute("user", user);
        Flight finalFlight = flight;
        model.addAttribute("files", storageService.loadAll(finalFlight.getId(), prof_name).map(
                        path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                                "serveFile", path.getFileName().toString(), finalFlight.getId()).build().toUri().toString())
                .collect(Collectors.toList()));
        return  "flight/flight_detail";
    }
    
    @GetMapping("/enter_flight/student")
    public String enter_flight2(@RequestParam("id") Long id, Model model, Principal principal) {
        Lecture lecture = this.lectureRepository.findById(id).get();
        model.addAttribute("lecture", lecture);
        Users user = this.UserRepository.findByName(principal.getName());
        Flight flight = this.flightRepository.findByTodayAndLectId(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), lecture.getId());
        String prof_name = flight.getPilot().getName();
        model.addAttribute("flight", flight);
        model.addAttribute("user", user);
        Flight finalFlight = flight;
        model.addAttribute("files", storageService.loadAll(finalFlight.getId(), prof_name).map(
                        path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                                "serveFile", path.getFileName().toString(), finalFlight.getId()).build().toUri().toString())
                .collect(Collectors.toList()));
        return "flight/flight_detail";
    }

    @GetMapping("/check_in_flight")
    public String check_in_flight(@RequestParam("id") Long id, Model model, Principal principal) {
        Users user = this.UserRepository.findByName(principal.getName());
        Lecture lecture = this.lectureRepository.findById(id).get();
        Flight flight = flightRepository.findByTodayAndLectId(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")), lecture.getId());
        model.addAttribute("flight", flight);
        model.addAttribute("user", user);
        return "flight/flight_check_in";
    }
    @PostMapping("/check_in_flight")
    public String check_in_flight(@RequestParam("id") Long id, @RequestParam("latitude") String latitude, @RequestParam("longitude") String longitude, Principal principal) {
        System.out.println("check_in_flight");
        Users user = this.UserRepository.findByName(principal.getName());
        Flight flight = this.flightRepository.findById(id).get();
        Lecture lecture = this.lectureRepository.findById(flight.getLecture().getId()).get();
        Attendance attendance = this.attendanceService.isStudentAttended(lecture.getName(), flight, user);
        if (attendance.getStatus().equals("출석")) {
            return "flight/flight_detail";
        }
        else {
            RestTemplate restTemplate = new RestTemplate();
            String url = "http://localhost:5000/lecture_check_in";
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            Map<String, String> param = new HashMap<>();
            System.out.println("student_id: " + user.getId().toString() + " lecture_name: " + lecture.getName() + " lecture_id: " + lecture.getId().toString() + " lecture_building: " + lecture.getBuilding() + " student_latitude: " + latitude + " student_longitude: " + longitude);


            param.put("student_id", user.getId().toString());
            param.put("lecture_name", lecture.getName());
            param.put("lecture_id", lecture.getId().toString());
            param.put("lecture_building", lecture.getBuilding());
            param.put("student_latitude", latitude);
            param.put("student_longitude", longitude);
            try {
                String paramJson = objectMapper.writeValueAsString(param);
                HttpEntity<String> entity = new HttpEntity<>(paramJson, headers);
                String response = restTemplate.postForObject(url, entity, String.class);
                System.out.println(response);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            return "redirect:/";
        }
    }
    @RequestMapping("/boarding/{id}")
    public String boarding(@PathVariable("id") Long id, Model model, Principal principal) {
        Flight flight = this.flightRepository.findById(id).get();
        String flight_name = new String(flight.getName().getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8);
        model.addAttribute("flight_name", flight_name);
        model.addAttribute("flight_id", flight.getIdentify());
        return "webrtc/lobby";
    }
}