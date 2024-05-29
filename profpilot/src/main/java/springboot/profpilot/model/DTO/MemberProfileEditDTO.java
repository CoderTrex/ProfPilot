package springboot.profpilot.model.DTO;


import lombok.Getter;
import lombok.Setter;

//        1 private String university;
//        2 private String name;
//        3 private Long studentId;
//        4 private String major;
//        5 private String phone;
//        6 private String role;
//        7 private String status;
//        8 private String create_at;
//        9 private String agree_at;
@Getter
@Setter
public class MemberProfileEditDTO {
    private String email;
    private String university;
    private String name;
    private String studentId;
    private String major;
    private String phone;
    private String role;
    private String status;
    private String createAt;
    private String agreeAt;
}
