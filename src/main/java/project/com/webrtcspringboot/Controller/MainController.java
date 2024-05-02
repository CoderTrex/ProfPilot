package project.com.webrtcspringboot.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import project.com.webrtcspringboot.Model.Lecture.LectureRepository;
import project.com.webrtcspringboot.Model.Lecture.LectureService;
import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.User.Users;

import java.security.Principal;

@RequiredArgsConstructor
@Controller
public class MainController {
    private final LectureRepository lectureRepository;
    private final UserService userService;

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
        model.addAttribute("lectureList", this.lectureRepository.findAllByUserId(user.getId()));
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
