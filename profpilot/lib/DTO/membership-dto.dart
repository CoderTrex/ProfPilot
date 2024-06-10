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