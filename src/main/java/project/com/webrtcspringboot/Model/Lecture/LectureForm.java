package project.com.webrtcspringboot.Model.Lecture;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LectureForm {
    @NotEmpty(message = "강의명을 입력해주세요.")
    @Size(max = 50, message = "강의명은 50자 이내로 입력해주세요.")
    private String lectureName;

    @NotEmpty(message = "강의실을 입력해주세요.")
    private String lectureRoom;

    @NotEmpty(message = "시작 시간을 입력해주세요.")
    private String lectureStartTime;

    @NotEmpty(message = "종료 시간을 입력해주세요.")
    private String lectureEndTime;
}
