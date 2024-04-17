package project.com.webrtcspringboot.Model.Lecture;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LectureRepository extends JpaRepository<Lecture, Long> {

    List<Lecture> findByName(String name);

    @Query("SELECT l FROM Lecture l WHERE l.name LIKE %:keyword%")
    List<Lecture> findByKeyword(String keyword);
}
