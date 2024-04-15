package project.com.webrtcspringboot.Model.attendance;

import org.springframework.data.jpa.repository.JpaRepository;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    Attendance findByUserId(Long id);
    Attendance findByLectName(String name);
}
