package project.com.webrtcspringboot.Model.User;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
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

    public void save(Users user) {
        this.userRepository.save(user);
    }

    public Users findById(Long id) {
        return this.userRepository.findById(id).orElse(null);
    }

    public Users findByName(String name) {
        return this.userRepository.findByName(name);
    }

    public Users findByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }
    public void signup(String username, String email, String password) {
        GenerateRandomString generateRandomString = new GenerateRandomString();
        Users user = new Users();
        user.setName(username);
        user.setEmail(email);
        user.setIdentifier(generateRandomString.getRandomPassword2(10) + username);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole("student");
        user.setStatus("normal");
        user.setPurchaseDate("none");
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
        if (passwordEncoder.matches(currentPassword, user.getPassword())) {
            user.setPassword(passwordEncoder.encode(newPassword));
            this.userRepository.save(user);
        }
    }

    public void requestProfAuth(String email, String name) {
        EmailController.sendEmailProfAuth(email, name);
    }
}