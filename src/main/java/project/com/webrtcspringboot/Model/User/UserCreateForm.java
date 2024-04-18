package project.com.webrtcspringboot.Model.User;

import groovy.transform.ExternalizeVerifier;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UserCreateForm {
    @Size(min = 2, max = 30)
    @NotEmpty(message = "name is required")
    private String name;

    @Email
    private String email;

    private String VerificationStatus;

    @NotEmpty(message = "password is required")
    private String password1;

    @NotEmpty(message = "password checking is required")
    private String password2;
}
