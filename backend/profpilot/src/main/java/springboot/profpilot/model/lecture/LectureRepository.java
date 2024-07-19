package springboot.profpilot.model.lecture;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface LectureRepository extends JpaRepository<Lecture, Long> {

    public Optional<Lecture> findById(Long id);
    public List<Lecture> findByName(String name);
    public List<Lecture> findByNameContaining(String name);
}
