package project.com.webrtcspringboot.Model.Lecture;

import jakarta.validation.Valid;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.User.UserRepository;


import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/lecture")
public class LectureController {
    private final LectureService lectureService;
    private final LectureRepository lectureRepository;
    private final UserRepository UserRepository;

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
        this.lectureService.create(lectureForm.getLectureName(), lectureForm.getLectureRoom(), lectureForm.getLectureDay(),
                                lectureForm.getLectureStartTime(), lectureForm.getLectureEndTime(), principal);
        return "redirect:/lecture/list";
    }

    @GetMapping("/enter")
    public String enter(@RequestParam("name") String lectureName, Model model) {
        model.addAttribute("lectureName", lectureName);
        return "webrtc/lobby";
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

    @PostMapping("/add/{lectureName}")
    public @ResponseBody String add(@PathVariable String lectureName, Principal principal) {
        System.out.println("add");
        this.lectureService.addUser(lectureName, principal);
        System.out.println("add");
        return "강의 추가 완료";
    }
}
