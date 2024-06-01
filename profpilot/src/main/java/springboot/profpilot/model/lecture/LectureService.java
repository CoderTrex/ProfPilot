package springboot.profpilot.model.lecture;


import lombok.RequiredArgsConstructor;
import org.antlr.v4.runtime.atn.LexerCustomAction;
import org.springframework.stereotype.Service;
import springboot.profpilot.model.member.Member;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LectureService {
    private final LectureRepository lectureRepository;

    public void saveLecture(Lecture lecture) {
        lectureRepository.save(lecture);
    }
    public List<Lecture> searchLecture(String searchText) {
        return lectureRepository.findByNameContaining(searchText);
    }

    public Lecture findLectureById(String lectureId) {
        Long id = Long.parseLong(lectureId);
        return lectureRepository.findById(id).orElse(null);
    }

    public String addStudent(Lecture lecture, Member member) {
        if (lecture.getStudents().contains(member)) {
            return "already";
        } else {
            lecture.getStudents().add(member);
            lectureRepository.save(lecture);
        }
        return "success";
    }
}
