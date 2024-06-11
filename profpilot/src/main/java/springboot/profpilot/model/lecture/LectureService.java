package springboot.profpilot.model.lecture;


import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.RequiredArgsConstructor;
import org.antlr.v4.runtime.atn.LexerCustomAction;
import org.springframework.stereotype.Service;
import springboot.profpilot.model.attendance.Attendance;
import springboot.profpilot.model.attendance.AttendanceRepository;
import springboot.profpilot.model.member.Member;
import springboot.profpilot.model.member.MemberService;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LectureService {
    private final LectureRepository lectureRepository;
    private final MemberService memberService;
    private final AttendanceRepository attendanceRepository;

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

    public int startLecture(Member member) {
        List<Lecture> lectureList = member.getLectures();

        if (lectureList == null) {
            return -1; // not lecture
        }
        for (Lecture lecture : lectureList) {
            if (lecture.getProfessor() == member) {
                String lectureDay = lecture.getDay().toLowerCase(); // ex) ["Mon", "Wed", "Fri"]
                String lectureStartTime = lecture.getStart_time();
                String nowDay = LocalDateTime.now().getDayOfWeek().toString().substring(0, 3).toLowerCase(); // ex) "Mon"
                String nowTime = LocalDateTime.now().getHour() + ":" + LocalDateTime.now().getMinute(); // ex) "10:30"
                if (lectureDay.contains(nowDay) && (lectureStartTime.compareTo(nowTime) >= -60 && lectureStartTime.compareTo(nowTime) <= 60)) {
                    return Integer.parseInt(lecture.getId().toString());
                }
            } else {
                return -3; // not this lecture professor
            }
        }
        return -2; // not lecture time
    }

    public int makeAttendance(Member member, int lectureId) {
        Lecture lecture = lectureRepository.findById((long) lectureId).orElse(null);
        if (lecture == null) {
            return -1;
        }
        List<Member> students = lecture.getStudents();
        String date = LocalDateTime.now().toString().substring(0, 10);

        if (member.getRole() != "ROLE_PROFESSOR") {
            Attendance attendance = attendanceRepository.findByLectureAndStudentAndDate(lecture, member, date);
            if (attendance != null) {
                return 0;
            }
            attendance = new Attendance();
            attendance.setLecture(lecture);
            attendance.setStudent(member);
            attendance.setDate(date);
            attendance.setStatus("professor");
            attendanceRepository.save(attendance);
            Attendance attendance1 = attendanceRepository.findByLectureAndStudentAndDate(lecture, member, date);

            lecture.getAttendances().add(attendance1);
            lectureRepository.save(lecture);

            member.getAttendances().add(attendance1);
            memberService.save(member);

        }


        for (Member student : students) {
            System.out.println("student : " + student.getEmail());
            Attendance attendance = attendanceRepository.findByLectureAndStudentAndDate(lecture, student, date);
            if (attendance != null) {
                continue;
            }
            attendance = new Attendance();
            attendance.setLecture(lecture);
            attendance.setStudent(student);
            attendance.setDate(date);
            attendance.setStatus("absent");
            attendanceRepository.save(attendance);
            Attendance attendance1 = attendanceRepository.findByLectureAndStudentAndDate(lecture, student, date);

            lecture.getAttendances().add(attendance1);
            lectureRepository.save(lecture);

            student.getAttendances().add(attendance1);
            System.out.println("student : " + student.getEmail() + "attendance: " + attendance1.getStatus());
            memberService.save(student);
        }
        return 0;
    }

}
