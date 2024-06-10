package springboot.profpilot.model.lecture;


import lombok.RequiredArgsConstructor;
import org.antlr.v4.runtime.atn.LexerCustomAction;
import org.springframework.stereotype.Service;
import springboot.profpilot.model.member.Member;

import java.time.LocalDateTime;
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

    public int generateFlight(Member member) {
        List<Lecture> lectureList = member.getLectures();

        if (lectureList == null) {
            return 0; // not lecture
        }
        for (Lecture lecture : lectureList) {
            if (lecture.getProfessor() == member) {
                String lectureDay = lecture.getDay().toLowerCase(); // ex) ["Mon", "Wed", "Fri"]
                String lectureStartTime = lecture.getStart_time();
                String nowDay = LocalDateTime.now().getDayOfWeek().toString().substring(0, 3).toLowerCase(); // ex) "Mon"
                String nowTime = LocalDateTime.now().getHour() + ":" + LocalDateTime.now().getMinute(); // ex) "10:30"
                System.out.println("lecture day: " + lectureDay + " now day: " + nowDay);
                System.out.println("lecture start time: " + lectureStartTime + " now time: " + nowTime);
                System.out.println("compare time: " + lectureStartTime.compareTo(nowTime));
                if (lectureDay.contains(nowDay) && (lectureStartTime.compareTo(nowTime) >= -60 && lectureStartTime.compareTo(nowTime) <= 60)) {
                    return 1; // success
                }
            } else {
                return 3; // not this lecture professor
            }
        }
        return 2; // not lecture time
    }
}
