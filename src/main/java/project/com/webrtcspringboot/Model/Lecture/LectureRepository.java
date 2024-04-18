package project.com.webrtcspringboot.Model.Lecture;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import project.com.webrtcspringboot.Model.User.Users;
import java.util.List;
import java.util.Optional;

public interface LectureRepository extends JpaRepository<Lecture, Long> {

    Lecture findByName(String name);



    Optional<Lecture> findById(Long id);

    @Query("SELECT l FROM Lecture l WHERE l.name LIKE %:keyword%")
    List<Lecture> findByKeyword(String keyword);

    @Query("SELECT l FROM Lecture l join l.users u WHERE u.id = :userId")
    List<Lecture> findAllByUserId(Long userId);
}
