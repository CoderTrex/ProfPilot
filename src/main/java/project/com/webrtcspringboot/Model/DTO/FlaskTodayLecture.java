package project.com.webrtcspringboot.Model.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class FlaskTodayLecture {
    private String result;

    @JsonProperty("this_time_lecture")
    private List<Long> thisTimeLecture;
}
