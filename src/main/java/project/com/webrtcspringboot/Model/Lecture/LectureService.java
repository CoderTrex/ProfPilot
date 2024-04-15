package project.com.webrtcspringboot.Model.Lecture;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class LectureService {
    private final LectureRepository lectureRepository;

    public void create(String lectureName, String lectureRoom, String lectureStartTime, String lectureEndTime) {
        Lecture lecture = new Lecture();
        lecture.setName(lectureName);
        lecture.setRoom(lectureRoom);
        lecture.setStartTime(lectureStartTime);
        lecture.setEndTime(lectureEndTime);
        this.lectureRepository.save(lecture);
    }
}
