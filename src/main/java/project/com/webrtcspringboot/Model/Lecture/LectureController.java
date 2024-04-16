package project.com.webrtcspringboot.Model.Lecture;

import jakarta.validation.Valid;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestParam;


import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/lecture")
public class LectureController {
    private final LectureService lectureService;
    private final LectureRepository lectureRepository;

    @GetMapping("/list")
    public String list(Model model, Principal principal) {
        String username = principal.getName();
        List<Lecture> lectureList = this.lectureRepository.findAll();
        model.addAttribute("userRole", "prof");
        model.addAttribute("lectureList", lectureList);
        return "Lecture/lecture_list";
    }

    @GetMapping("/create")
    public String create(LectureForm lectureForm) {
        return "Lecture/lecture_create";
    }


    @PostMapping("/create")
    public String create(@Valid LectureForm lectureForm, BindingResult bindingResult, Principal principal) {
        if (bindingResult.hasErrors()) {
            return "Lecture/lecture_create";
        }
        this.lectureService.create(lectureForm.getLectureName(), lectureForm.getLectureRoom(),
                                lectureForm.getLectureStartTime(), lectureForm.getLectureEndTime(), principal);
        return "redirect:/lecture/list";
    }

    @GetMapping("/enter")
    public String enter(@RequestParam("name") String lectureName, Model model) {
        model.addAttribute("lectureName", lectureName);
        return "webrtc/lobby";
    }

}
