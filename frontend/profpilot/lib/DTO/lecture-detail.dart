class LectureDetailDTO {
  final String lectureId;
  final String lectureName;
  final String lectureDay;
  final String lectureStartTime;
  final String lectureEndTime;
  final List<AttendanceDTO> attendanceList;

  LectureDetailDTO({
    required this.lectureId,
    required this.lectureName,
    required this.lectureDay,
    required this.lectureStartTime,
    required this.lectureEndTime,
    required this.attendanceList,
  });


  factory LectureDetailDTO.fromJson(Map<String, dynamic> json) {
    var list = json['attendanceList'] as List;
    List<AttendanceDTO> attendanceList = list.map((i) => AttendanceDTO.fromJson(i)).toList();

    return LectureDetailDTO(
      lectureId: json['lectureId'],
      lectureName: json['lectureName'],
      lectureDay: json['lectureDay'],
      lectureStartTime: json['lectureStartTime'],
      lectureEndTime: json['lectureEndTime'],
      attendanceList: attendanceList,
    );
  }
}

class AttendanceDTO {
  final String date;
  final String status;

  AttendanceDTO({
    required this.date,
    required this.status,
  });

  factory AttendanceDTO.fromJson(Map<String, dynamic> json) {
    return AttendanceDTO(
      date: json['date'],
      status: json['status'],
    );
  }
}