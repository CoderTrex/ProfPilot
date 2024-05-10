package project.com.webrtcspringboot.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import project.com.webrtcspringboot.Model.DTO.FlaskTodayLecture;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.Lecture.LectureRepository;
import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.User.Users;
import java.util.ArrayList;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
public class MainController {
    private final LectureRepository lectureRepository;
    private final UserService userService;
    private final ObjectMapper objectMapper;

    @GetMapping("/")
    public String root() {
        return "redirect:/main";
    }

    @GetMapping("/main")
    public String main(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/login_or_signup";
        }
        Users user = this.userService.findByEmail(principal.getName());
        String date = "";
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://flask-container:5000/today_lecture_list";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        Map<String, String> param = new HashMap<>();
        if (user.getRole().equals("prof")) {
            param.put("user_or_prof", "prof");
            param.put("user_id", "null");
            param.put("professor_id", user.getId().toString());
        }
        else {
            param.put("user_or_prof", "user");
            param.put("user_id", user.getId().toString());
            param.put("professor_id", "null");
        }
        try {
            String paramJson = objectMapper.writeValueAsString(param);
            HttpEntity<String> entity = new HttpEntity<>(paramJson, headers);
            String jsonResponse = restTemplate.postForObject(url, entity, String.class);
            ObjectMapper objectMapper = new ObjectMapper();
            FlaskTodayLecture response = objectMapper.readValue(jsonResponse, FlaskTodayLecture.class);
            List<Long> lectureIdList = response.getThisTimeLecture();
            List<Lecture> today_lectureList = new ArrayList<>();
            for (Long lg : lectureIdList) {
                Lecture lecture = this.lectureRepository.findByLongId(lg);
                today_lectureList.add(lecture);
                date = lecture.getLectureDay();
            }
            model.addAttribute("today_lectureList", today_lectureList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        model.addAttribute("not_today_lectureList", this.lectureRepository.findAllByUserIdAndDate(user.getId(), date));
        model.addAttribute("user", user);
        return "main";
    }

    @GetMapping("/login_or_signup")
    public String login_or_signup() {
        return "user/login_or_signup";
    }

    @GetMapping("/lobby.html")
    public String lobby_home() {
        return "webrtc/lobby";
    }

    @GetMapping("/room.html")
    public String lecture(@RequestParam("room") String room) {
        return "webrtc/room";
    }
}
