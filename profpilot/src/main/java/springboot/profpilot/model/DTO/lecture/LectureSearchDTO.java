package springboot.profpilot.model.DTO.lecture;


import lombok.Getter;
import lombok.Setter;

// 1. 검색어, 2. 강의명, 3. 교수명, 4. 강의실
// 5. 요일, 6. 시간대(시작 시간, 종료 시간) 7. 건물


@Getter
@Setter
public class LectureSearchDTO {
    private String searchText;
    private String lectureId;
    private String lectureName;
    private String professorName;
    private String room;
    private String building;
    private String day;
    private String startTime;
    private String endTime;

    public LectureSearchDTO(String lectureId, String lectureName, String day, String startTime, String endTime, String building, String room, String professorName) {
        this.lectureId = lectureId;
        this.lectureName = lectureName;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
        this.building = building;
        this.room = room;
        this.professorName = professorName;
    }
}
