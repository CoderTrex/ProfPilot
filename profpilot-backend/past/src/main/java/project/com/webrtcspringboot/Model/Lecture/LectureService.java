package project.com.webrtcspringboot.Model.Lecture;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.com.webrtcspringboot.Model.User.UserRepository;
//import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.User.Users;

import javax.swing.plaf.PanelUI;
import java.security.Principal;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class LectureService {
    private final LectureRepository lectureRepository;
    private final UserRepository userRepository;

    public Long create(String lectureName,      String lectureBuilding,
                       String lectureRoom,      String lectureDay,
                       String lectureStartTime, String lectureEndTime,
                       String lecturePassword,  Principal principal) {
        Lecture lecture = new Lecture();
        lecture.setName(lectureName);
        lecture.setBuilding(lectureBuilding);
        lecture.setRoom(lectureRoom);
        lecture.setLectureDay(lectureDay);
        lecture.setStartTime(lectureStartTime);
        lecture.setEndTime(lectureEndTime);
        lecture.setLecturePassword(lecturePassword);
        Users user = this.userRepository.findByEmail(principal.getName());
        lecture.setProfessor(user);
        this.lectureRepository.save(lecture);
        return lecture.getId();
    }

    public void addUser(Long lectureId, Principal principal) {
        Optional<Lecture> lecture = this.lectureRepository.findById(lectureId);
        if (lecture.isPresent()) {
            Users user = this.userRepository.findByEmail(principal.getName());
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

    public void addProf(Long lectureId, Principal principal) {
        Optional<Lecture> lecture = this.lectureRepository.findById(lectureId);
        if (lecture.isPresent()) {
            Users user = this.userRepository.findByEmail(principal.getName());
            lecture.get().getUsers().add(user);
            this.lectureRepository.save(lecture.get());
        } else {
            throw new IllegalArgumentException("Lecture not found");
        }
    }


    public void deleteUser(Long id, Principal principal) {
        Optional<Lecture> lecture = Optional.ofNullable(this.lectureRepository.findById(id).orElse(null));
        Users user = this.userRepository.findByEmail(principal.getName());
        if (lecture.isPresent()) {
            if (lecture.get().getUsers().contains(user)) {
                lecture.get().getUsers().remove(user);
                this.lectureRepository.save(lecture.get());
            }
        } else {
            throw new IllegalArgumentException("Lecture not found");
        }
    }

    public void deleteAllUsers(Long id) {
        Optional<Lecture> lecture = Optional.ofNullable(this.lectureRepository.findById(id).orElse(null));
        if (lecture.isPresent()) {
            lecture.get().getUsers().clear();
            this.lectureRepository.save(lecture.get());
        } else {
            throw new IllegalArgumentException("Lecture not found");
        }
    }
}
