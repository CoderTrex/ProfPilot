
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-page.dart';


class MyEditDTO {

  String email;
  String university;
  String name;
  String studentId;
  String major;
  String phone;
  String role;
  String status;
  String createAt;
  String agreeAt;

  MyEditDTO({
    required this.email,
    required this.university,
    required this.name,
    required this.studentId,
    required this.major,
    required this.phone,
    required this.role,
    required this.status,
    required this.createAt,
    required this.agreeAt
  });

  factory MyEditDTO.fromResponse(final response) {
    return MyEditDTO(
      email: response.data['email'],
      university: response.data['university'],
      name: response.data['name'],
      studentId: response.data['studentId'],
      major: response.data['major'],
      phone: response.data['phone'],
      role: response.data['role'],
      status: response.data['status'],
      createAt: response.data['createAt'],
      agreeAt: response.data['agreeAt']
    );
  }

  factory MyEditDTO.empty() {
    return MyEditDTO(
      email: '',
      university: '',
      name: '',
      studentId: '',
      major: '',
      phone: '',
      role: '',
      status: '',
      createAt: '',
      agreeAt: ''
    );
  }
}