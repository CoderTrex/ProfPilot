package project.com.webrtcspringboot.Model.Lecture;

import org.springframework.data.jpa.repository.JpaRepository;

public interface LectureRepository extends JpaRepository<Lecture, Long> {
    Lecture findByName(String name);
}
