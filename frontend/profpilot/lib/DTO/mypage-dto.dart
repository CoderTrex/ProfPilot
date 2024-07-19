class MyPageDTO {
  String name;
  String studentId;
  String email;
  String membershipGrade;
  String role;
  String cloudGrade;

  MyPageDTO({
    required this.name,
    required this.studentId,
    required this.email,
    required this.membershipGrade,
    required this.role,
    required this.cloudGrade,
  });

  factory MyPageDTO.fromResponse(final response) {
    return MyPageDTO(
      name: response.data['name'],
      studentId: response.data['studentId'],
      email: response.data['email'],
      role: response.data['role'],
      membershipGrade: response.data['membershipGrade'],
      cloudGrade: response.data['cloudGrade'],
    );
  }
  
// make default value
  factory MyPageDTO.empty() {
    return MyPageDTO(
      name: '',
      studentId: '',
      email: '',
      membershipGrade: '',
      role: '',
      cloudGrade: '',
    );
  }
}