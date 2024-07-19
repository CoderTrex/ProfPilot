package springboot.profpilot.model.lecture;


import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;
import springboot.profpilot.model.DTO.lecture.LectureAddDTO;
import springboot.profpilot.model.DTO.lecture.LectureCreateDTO;
import springboot.profpilot.model.DTO.lecture.LectureIdDTO;
import springboot.profpilot.model.DTO.lecture.LectureSearchDTO;
import springboot.profpilot.model.attendance.Attendance;
import springboot.profpilot.model.attendance.AttendanceService;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.member.MemberService;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;



@RestController
@RequiredArgsConstructor
@RequestMapping("/lecture")
public class LectureController {
    private final LectureService lectureService;
    private final MemberService memberService;
    static class AttendanceDTO {
        final String date;
        final String status;

        AttendanceDTO(String date, String status) {
            this.date = date;
            this.status = status;
        }
    }


    @PostMapping("/page")
    public Map<String, Object> lecturePage(Principal principal, @RequestBody LectureIdDTO lectureIdDTO) {
        Member member = memberService.findByEmail(principal.getName());
        Lecture lecture = lectureService.findLectureById(lectureIdDTO.getLectureId());
        List<Attendance> attendances = member.getAttendances();
        Map<String, Object> response = new HashMap<>();

        List<AttendanceDTO> attendanceDTOList = attendances.stream().map(attendance -> new AttendanceDTO(
                attendance.getDate().toString(),
                attendance.getStatus()
        )).collect(Collectors.toList());

        response.put("lectureId", lecture.getId().toString());
        response.put("lectureName", lecture.getName());
        response.put("lectureDay", lecture.getDay());
        response.put("lectureStartTime", lecture.getStart_time());
        response.put("lectureEndTime", lecture.getEnd_time());
        response.put("attendanceList", attendanceDTOList);
        return response;
    }


    @PostMapping("/create")
    public String createLecture(@RequestBody LectureCreateDTO lectureCreateDTO, Principal principal) {//        System.out.println(lectureCreateDTO.getLectureName());
        Member member = memberService.findByEmail(principal.getName());
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

        memberService.addLecture(member, lecture);

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

    @PostMapping("/generate")
    public Map<String, String> generate(Principal principal) {
        Member member = memberService.findByEmail(principal.getName());
        Map<String, String> response;

        if (member.getRole().equals("ROLE_PROFESSOR")) {
            int result = lectureService.startLecture(member);
            if (result == -1) {
                response = Map.of("response", "not lecture");
                return response;
            } else if (result == -2) {
                response = Map.of("response", "not lecture time");
                return response;
            } else if (result == -3) {
                response = Map.of("response", "not this lecture professor");
                return response;
            } else {
                int status = lectureService.makeAttendance(member, result);
                System.out.println("status : " + status);

                response = Map.of("response", "success", "lectureId", String.valueOf(result));
                return response;
            }
        } else {
            response = Map.of("response", "not professor");
            return response;
        }
    }



}
