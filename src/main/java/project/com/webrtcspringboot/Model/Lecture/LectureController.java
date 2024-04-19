package project.com.webrtcspringboot.Model.Lecture;

import jakarta.validation.Valid;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.User.UserRepository;
import project.com.webrtcspringboot.Model.attendance.Attendance;
import project.com.webrtcspringboot.Model.attendance.AttendanceRepository;
import project.com.webrtcspringboot.Model.flight.FlightService;


import javax.swing.plaf.PanelUI;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/lecture")
public class LectureController {
    private final LectureService lectureService;
    private final LectureRepository lectureRepository;
    private final UserRepository UserRepository;
    private final UserService userService;
    private final AttendanceRepository attendanceRepository;
    private final FlightService flightService;


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
        this.flightService.createFlight(lectureForm.getLectureName(), lectureForm.getLectureRoom(), lectureForm.getLectureDay(),
                                lectureForm.getLectureStartTime(), lectureForm.getLectureEndTime(), principal);
//        add(lectureRepository.findByName(lectureForm.getLectureName()).getId(), principal);
        return "redirect:/lecture/list";
    }

    @GetMapping("/enter")
    public String enter(@RequestParam("name") String lectureName, Model model, Principal principal) {
        Users user = this.UserRepository.findByName(principal.getName());
        Lecture lecture = this.lectureRepository.findByName(lectureName);
        model.addAttribute("lecture", lecture);
        ArrayList<Attendance> attendance = this.attendanceRepository.findByLectNameAndUserId(lectureName, user);
        model.addAttribute("attendance", attendance);
        return "lecture/lecture_detail";
        //        return "webrtc/lobby";
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

//    <a th:href="@{/lecture/delete(name=${lecture.name})}">
    @GetMapping("/delete/{name}")
    public String delete(@PathVariable String name, Principal principal) {
        this.lectureService.deleteUser(name, principal);
        return "redirect:/lecture/list";
    }
}
