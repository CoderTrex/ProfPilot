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


import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/lecture")
public class LectureController {
    private final LectureService lectureService;
    private final LectureRepository lectureRepository;

    @GetMapping("/list")
    public String list(Model model) {
        List<Lecture> lectureList = this.lectureRepository.findAll();
        model.addAttribute("userRole", "prof");
        model.addAttribute("lectureList", lectureList);
        return "Lecture/lecture_list";
    }

    @GetMapping("/create")
    public String create() {
        return "Lecture/lecture_create";
    }

//    @GetMapping("/create")
//    public String create(Model model) {
//        model.addAttribute("lectureForm", new LectureForm());
//        return "Lecture/lecture_create";
//    }

    @PostMapping("/create")
    public String create(@Valid LectureForm lectureForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "Lecture/lecture_create";
        }
        this.lectureService.create(lectureForm.getLectureName(), lectureForm.getLectureRoom(),
                                lectureForm.getLectureStartTime(), lectureForm.getLectureEndTime());
        return "redirect:/lecture/list";
    }
}
