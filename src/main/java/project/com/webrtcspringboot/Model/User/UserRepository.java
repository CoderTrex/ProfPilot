package project.com.webrtcspringboot.Model.User;

import org.springframework.data.jpa.repository.JpaRepository;



public interface UserRepository extends JpaRepository<Users, Long> {
    Users findByName(String name);
}