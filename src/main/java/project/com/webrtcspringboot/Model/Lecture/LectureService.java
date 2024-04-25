package project.com.webrtcspringboot.Model.Lecture;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.com.webrtcspringboot.Model.User.UserRepository;
import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.User.Users;

import javax.swing.plaf.PanelUI;
import java.security.Principal;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class LectureService {
    private final LectureRepository lectureRepository;
    private final UserRepository userRepository;

    public void create(String lectureName, String lectureBuilding,
                       String lectureRoom, String lectureDay,
                       String lectureStartTime, String lectureEndTime,
                       Principal principal) {
        Lecture lecture = new Lecture();
        lecture.setName(lectureName);
        lecture.setBuilding(lectureBuilding);
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
        if (lecture.isPresent()) {
            Users user = this.userRepository.findByName(principal.getName());
            if (lecture.get().getUsers().contains(user)) {
                return;
            }
            else {
                lecture.get().getUsers().add(user);
            }
            this.lectureRepository.save(lecture.get());
        } else {
            throw new IllegalArgumentException("Lecture not found");
        }
    }


    public void deleteUser(Long id, Principal principal) {
        Optional<Lecture> lecture = Optional.ofNullable(this.lectureRepository.findById(id).orElse(null));
        Users user = this.userRepository.findByName(principal.getName());
        if (lecture.isPresent()) {
            if (lecture.get().getUsers().contains(user)) {
                lecture.get().getUsers().remove(user);
                this.lectureRepository.save(lecture.get());
            }
        } else {
            throw new IllegalArgumentException("Lecture not found");
        }
    }
}
