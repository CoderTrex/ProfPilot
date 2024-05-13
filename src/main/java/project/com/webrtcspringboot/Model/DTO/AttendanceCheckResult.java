package project.com.webrtcspringboot.Model.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;



@Getter
@Setter
public class AttendanceCheckResult {
    private String result;
    private String entrance;
    private String late;
    private String distance; // "distance" 필드 추가

    @JsonProperty("case")
    private String caseResult;

    private int target_time; // target_time 필드에 대응되는 필드
    private int now_time; // now_time 필드에 대응되는 필드
}
