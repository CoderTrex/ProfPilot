package project.com.webrtcspringboot.Model.User;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;
import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.User.email.EmailController;
import project.com.webrtcspringboot.Model.User.email.GenerateRandomString;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public List<Users> findAll() {
        return this.userRepository.findAll();
    }

    public Users findByName(String name) {
        return this.userRepository.findByName(name);
    }
    public void signup(String username, String email, String password) {
        Users user = new Users();
        user.setName(username);
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole("student");
        user.setStatus("activate");
        this.userRepository.save(user);
    }

    public Boolean findPassword(String email) {
        Users user = this.userRepository.findByEmail(email);
        if (user == null) {
            return false;
        }
        else {
            GenerateRandomString randomString = new GenerateRandomString();
            String code = randomString.getRandomPassword2(14);
            EmailController.sendEmailNewPassword(user.getName(), email, code);
            user.setPassword(passwordEncoder.encode(code));
            this.userRepository.save(user);
            return true;
        }
    }

    public void changePassword(String name, String currentPassword, String newPassword) {
        Users user = this.userRepository.findByName(name);
        System.out.println("Current password: " + currentPassword);
        if (passwordEncoder.matches(currentPassword, user.getPassword())) {
            System.out.println("Password matched");
            user.setPassword(passwordEncoder.encode(newPassword));
            this.userRepository.save(user);
        }
    }

//    this.userService.requestProfAuth(email);  해당 이메일을 서비스의 공식계정 이메일에 요청하는 이메일을 보내게 한다.
    public void requestProfAuth(String email, String name) {
        EmailController.sendEmailProfAuth(email, name);
    }
}