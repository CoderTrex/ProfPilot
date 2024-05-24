package springboot.profpilot.global.Utils.DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckEmail {
    private String email;
    private String verifyCode;
}
