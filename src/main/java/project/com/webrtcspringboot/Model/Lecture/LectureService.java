package project.com.webrtcspringboot.Model.Lecture;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.com.webrtcspringboot.Model.User.UserRepository;
import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.User.Users;

import java.security.Principal;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class LectureService {
    private final LectureRepository lectureRepository;
    private final UserRepository userRepository;
    public void create(String lectureName, String lectureRoom, String lectureDay,
            String lectureStartTime, String lectureEndTime, Principal principal) {
        Lecture lecture = new Lecture();
        lecture.setName(lectureName);
        lecture.setRoom(lectureRoom);
        lecture.setLectureDay(lectureDay);
        lecture.setStartTime(lectureStartTime);
        lecture.setEndTime(lectureEndTime);
        Users user = this.userRepository.findByName(principal.getName());
        lecture.setProfessor(user);
        this.lectureRepository.save(lecture);
    }

    public void addUser(Long lectureId, Principal principal) {
        Optional<Lecture> lecture = this.lectureRepository.findById(lectureId);
        Users user = this.userRepository.findByName(principal.getName());
        if (lecture.get().getUsers().contains(user)) {
            return;
        }
        else {
            lecture.get().getUsers().add(user);
        }
        this.lectureRepository.save(lecture.get());
    }
}
