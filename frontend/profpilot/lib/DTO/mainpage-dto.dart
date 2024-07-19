class MainPageDTO {
  final String role;
  final String name;
  final String email;
  final int lecturesSize;
  final List<LectureDTO> mainPageDTOList;

  MainPageDTO({
    required this.role,
    required this.name,
    required this.email,
    required this.lecturesSize,
    required this.mainPageDTOList,
  });

  factory MainPageDTO.fromJson(Map<String, dynamic> json) {
    var list = json['mainPageDTOList'] as List;
    List<LectureDTO> lectureList = list.map((i) => LectureDTO.fromJson(i)).toList();

    return MainPageDTO(
      role: json['role'],
      name: json['name'],
      email: json['email'],
      lecturesSize: json['lectures-size'],
      mainPageDTOList: lectureList,
    );
  }
}

class LectureDTO {
  final String lectureId;
  final String lectureName;
  final String lectureDay;
  final String lectureStartTime;
  final String lectureEndTime;
  final String lectureBuilding;
  final String lectureRoom;
  final String lectureProfessor;

  LectureDTO({
    required this.lectureId,
    required this.lectureName,
    required this.lectureDay,
    required this.lectureStartTime,
    required this.lectureEndTime,
    required this.lectureBuilding,
    required this.lectureRoom,
    required this.lectureProfessor,
  });

  factory LectureDTO.fromJson(Map<String, dynamic> json) {
    
    return LectureDTO(
      lectureId: json['lectureId'],
      lectureName: json['lectureName'],
      lectureDay: json['lectureDay'],
      lectureStartTime: json['lectureStartTime'],
      lectureEndTime: json['lectureEndTime'],
      lectureBuilding: json['lectureBuilding'],
      lectureRoom: json['lectureRoom'],
      lectureProfessor: json['lectureProfessor'],
    );
  }
}
