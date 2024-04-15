package project.com.webrtcspringboot.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {
    @GetMapping("/")
    public String root() {
        return "redirect:/main";
    }

    @GetMapping("/main")
    public String main() {
        return "main";
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
