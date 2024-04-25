package project.com.webrtcspringboot.Model.DTO;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
@Getter
@RequiredArgsConstructor
public class RequestSendToFlaskDTO {
    private final String lecture_name;
    private final Long lecture_id;
    private final Long flight_id;
}
