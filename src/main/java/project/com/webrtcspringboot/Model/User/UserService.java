package project.com.webrtcspringboot.Model.User;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;
import project.com.webrtcspringboot.Model.Lecture.Lecture;

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
        user.setStatus("active");
        this.userRepository.save(user);
    }
}