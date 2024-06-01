package springboot.profpilot.model.lecture;


import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;
import springboot.profpilot.model.DTO.lecture.LectureAddDTO;
import springboot.profpilot.model.DTO.lecture.LectureCreateDTO;
import springboot.profpilot.model.DTO.lecture.LectureSearchDTO;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.member.MemberService;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/lecture")
public class LectureController {
    private final LectureService lectureService;
    private final MemberService memberService;

    @PostMapping("/create")
    public String createLecture(@RequestBody LectureCreateDTO lectureCreateDTO, Principal principal) {//        System.out.println(lectureCreateDTO.getLectureName());

        Lecture lecture = new Lecture();
        lecture.setName(lectureCreateDTO.getLectureName());
        lecture.setDay(lectureCreateDTO.getLectureDay());
        lecture.setStart_time(lectureCreateDTO.getLectureStartTime());
        lecture.setEnd_time(lectureCreateDTO.getLectureEndTime());
        lecture.setBuilding(lectureCreateDTO.getBuilding());
        lecture.setRoom(lectureCreateDTO.getRoom());
        lecture.setPassword(lectureCreateDTO.getPassword());
        lecture.setProfessor(memberService.findByEmail(principal.getName()));
        lectureService.saveLecture(lecture);
        return "create lecture";
    }


    @PostMapping(value = "/search", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public List<LectureSearchDTO> searchLecture(@RequestBody LectureSearchDTO lectureSearchDTO) {
        List<Lecture> lectures = lectureService.searchLecture(lectureSearchDTO.getSearchText());

        return lectures.stream().map(lecture -> new LectureSearchDTO(
                lecture.getId().toString(),
                lecture.getName(),
                lecture.getDay(),
                lecture.getStart_time(),
                lecture.getEnd_time(),
                lecture.getBuilding(),
                lecture.getRoom(),
                lecture.getProfessor().getName()
        )).collect(Collectors.toList());
    }

    @PostMapping("/Enrolment")
    public String Enrolment(@RequestBody LectureAddDTO lectureAddDTO, Principal principal) {
        try {
            Lecture lecture = lectureService.findLectureById(lectureAddDTO.getLectureId());
            Member member = memberService.findByEmail(principal.getName());
            String response1 = "fail", response2 = "fail";
            if (lecture.getPassword().equals(lectureAddDTO.getPassword())) {
                response1 = lectureService.addStudent(lecture, member);
                response2 = memberService.addLecture(member, lecture);
            }
            if (response1.equals("success") || response2.equals("success")) {
                return "success";
            } else {
                return "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
}
