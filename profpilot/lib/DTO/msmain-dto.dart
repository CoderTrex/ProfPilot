  // dto에 필요한 목록
  // 1. 현재 역할
  // 2. 교수 권한 신청 여부
  // 3. 교수 권한 허가 대학
  // 4. 맴버쉽 등급
  // 5. 맴버쉽 만료일
  // 6. 클라우드 용량

class MsmainDTO {
  String  isProfessor;

  String  role;
  String  professorAuthapply;
  String  professorUniversity;

  String  membershipGrade;
  String  membershipExpirationDate;
  String  cloudCapacity;

  MsmainDTO({
    required this.isProfessor,
    required this.role,
    required this.professorAuthapply,
    required this.professorUniversity,
    required this.membershipGrade,
    required this.membershipExpirationDate,
    required this.cloudCapacity,
  });

  factory MsmainDTO.fromResponse(final response) {
    return MsmainDTO(
      isProfessor: response.data['isProfessor'],
      role: response.data['role'],
      professorAuthapply: response.data['professorAuthapply'],
      professorUniversity: response.data['professorUniversity'],
      membershipGrade: response.data['membershipGrade'],
      membershipExpirationDate: response.data['membershipExpirationDate'],
      cloudCapacity: response.data['cloudCapacity'],
    );
  }

  factory MsmainDTO.empty() {
    return MsmainDTO(
      isProfessor: '',
      role: '',
      professorAuthapply: '',
      professorUniversity: '',
      membershipGrade: '',
      membershipExpirationDate: '',
      cloudCapacity: '',
    );
  }
}