package springboot.profpilot.model.DTO;

import lombok.Getter;
import lombok.Setter;


//data: {
//        'LectureName': LectureName,
//        'LectureDay': LectureDay,
//        'LectureStartTime': LectureStartTime,
//        'LectureEndTime': LectureEndTime,
//        'Building': Building,
//        'Password': Password,
//        },
@Getter
@Setter
public class LectureCreateDTO {
    private String LectureName;
    private String LectureDay;
    private String LectureStartTime;
    private String LectureEndTime;
    private String Building;
    private String Password;
}
