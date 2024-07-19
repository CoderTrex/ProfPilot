// 건물
// 요일
// 마치는시간
// 시작시간
// 이름
// 비밀번호

class LectureDTO {
  String building;
  String day;
  String endTime;
  String startTime;
  String name;
  String password;

  LectureDTO({
    required this.building, 
    required this.day, 
    required this.endTime, 
    required this.startTime, 
    required this.name, 
    required this.password
  });

  factory LectureDTO.fromResponse(final response) {
    return LectureDTO(
      building: response.data['building'],
      day: response.data['day'],
      endTime: response.data['endTime'],
      startTime: response.data['startTime'],
      name: response.data['name'],
      password: response.data['password']
    );
  }

  factory LectureDTO.empty() {
    return LectureDTO(
      building: '',
      day: '',
      endTime: '',
      startTime: '',
      name: '',
      password: ''
    );
  }

  Map<String, dynamic> toJson() => {
    'building': building,
    'day': day,
    'endTime': endTime,
    'startTime': startTime,
    'name': name,
    'password': password,
  };
}