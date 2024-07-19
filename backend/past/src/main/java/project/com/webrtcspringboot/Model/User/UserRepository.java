package project.com.webrtcspringboot.Model.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import project.com.webrtcspringboot.Model.Lecture.Lecture;


public interface UserRepository extends JpaRepository<Users, Long> {
    Users findByName(String name);
    Users findByEmail(String email);

}