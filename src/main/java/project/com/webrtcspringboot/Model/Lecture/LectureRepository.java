package project.com.webrtcspringboot.Model.Lecture;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import project.com.webrtcspringboot.Model.User.Users;
import java.util.List;

public interface LectureRepository extends JpaRepository<Lecture, Long> {

    Lecture findByName(String name);

    @Query("SELECT l FROM Lecture l WHERE l.name LIKE %:keyword%")
    List<Lecture> findByKeyword(String keyword);


    @Query("SELECT l FROM Lecture l join l.users u WHERE u.id = :userId")
    List<Lecture> findAllByUserId(Long userId);
}
