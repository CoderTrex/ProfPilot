package springboot.profpilot.model.lecture;


import org.springframework.jdbc.datasource.init.ScriptUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import springboot.profpilot.model.DTO.LectureCreateDTO;

@RestController
@RequestMapping("/lecture")
public class LectureController {

    @PostMapping("/create")
    public String createLecture(@RequestBody LectureCreateDTO lectureCreateDTO) {
        System.out.println(lectureCreateDTO.getLectureName());
        System.out.println(lectureCreateDTO.getLectureDay());
        System.out.println(lectureCreateDTO.getLectureStartTime());
        System.out.println(lectureCreateDTO.getLectureEndTime());
        System.out.println(lectureCreateDTO.getBuilding());
        System.out.println(lectureCreateDTO.getPassword());
        return "create lecture";
    }
}
