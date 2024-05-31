import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';
import 'package:profpilot/main.dart';
import "dart:html";
import 'package:day_picker/day_picker.dart';

import 'package:dio/dio.dart';

class LectureGeneratePage extends StatefulWidget {
  const LectureGeneratePage({super.key});

  @override
  State<LectureGeneratePage> createState() => _LectureGeneratePageState();

}

class _LectureGeneratePageState extends State<LectureGeneratePage> {

  String building = '건물을 선택하세요';
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  final List<DayInWeek> _days = [
    DayInWeek(
      "Sun", dayKey: 'Sun',
    ),
    DayInWeek(
      "Mon", dayKey: 'Mon',
    ),
    DayInWeek(
      "Tue", dayKey: 'Tue'
    ),
    DayInWeek(
      "Wed", dayKey: 'Wed',
    ),
    DayInWeek(
      "Thu", dayKey: 'Thu',
    ),
    DayInWeek(
      "Fri", dayKey: 'Fri',
    ),
    DayInWeek(
      "Sat", dayKey: 'Sat',
    ),
  ];


  Future<TimeOfDay?> showCustomTimePicker({
                            required BuildContext context,
                            required TimeOfDay initialTime,}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.input,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            hourMinuteShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            dialBackgroundColor: Colors.grey.shade900,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
              textScaleFactor: 1.0,
            ),
            child: Builder(
              builder: (BuildContext context) {
                return Dialog(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 300,
                    ),
                    child: child,
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

  Future<void> _SendLectureData(TextEditingController LectureNameController, TextEditingController LectureDayController, TextEditingController LectureStartTimeController, TextEditingController LectureEndTimeController, TextEditingController BuildingController, TextEditingController PasswordController) async {
    final String LectureName = LectureNameController.text;
    final String LectureDay = LectureDayController.text;
    final String LectureStartTime = LectureStartTimeController.text;
    final String LectureEndTime = LectureEndTimeController.text;
    final String Building = building;
    final String Password = PasswordController.text;

    print("--------------------");
    print(LectureName);
    print(LectureDay);
    print(LectureStartTime);
    print(LectureEndTime);
    print(Building);
    print(Password);
    print("--------------------");

    final Dio dio = Dio();

    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      );
    }

    final response = await dio.post(
      'http://localhost:8080/lecture/create',
      options: Options(
          headers: {
            'access' : accessToken,
          },
          extra: {
            'withCredentials': true,
          },
      ),
      data: {
        'LectureName': LectureName,
        'LectureDay': LectureDay,
        'LectureStartTime': LectureStartTime,
        'LectureEndTime': LectureEndTime,
        'Building': Building,
        'Password': Password,
      },
    );

    if (response.statusCode == 200) {
      window.alert('강의가 생성되었습니다.');
    } else {
      window.alert('강의 생성에 실패했습니다.');
    }

  }

  final TextEditingController LectureNameController = TextEditingController();
  final TextEditingController LectureDayController = TextEditingController();
  final TextEditingController LectureStartTimeController = TextEditingController();
  final TextEditingController LectureEndTimeController = TextEditingController();
  final TextEditingController BuildingController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    String breakpointName = getBreakpointName(screenSize.width);
    ThemeMode themeMode = ThemeMode.dark;
  
    return Scaffold(
        body:
            Container(
              width: screenSize.width,
              height: screenSize.height,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFF444444)),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row( // 강의 이름
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5 - 150,
                      ),
                      Container(
                          width: 300,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 12,
                                offset: Offset(2, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: TextField(
                            
                            controller: LectureNameController,
                            autofocus: true,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '강의 이름',
                                hintStyle: TextStyle(
                                  color: Color(0xFF3D3D3D),
                                  fontSize: 10,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.14,
                                )),
                            style: const TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 10,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row( // 강의 요일
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5 - 150,
                      ),
                      
                      SizedBox(
                        height: 40,
                        child: SelectWeekDays(
                          width: 300,
                          fontSize: 10,
                          padding: 4.0,
                          fontWeight: FontWeight.w500,
                          days: _days,
                          border: false,
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.black,
                          ),
                          onSelect: (values) { // <== Callback to handle the selected days
                            LectureDayController.text = values.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row( // 강의 시작 시간
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5 - 150,
                      ),
                      Text(
                        // ignore: unnecessary_null_comparison
                        selectedStartTime != null
                            ? '${selectedStartTime!.hour}:${selectedStartTime!.minute}'
                            : '강의 시작 시간을 선택하세요',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 10,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(100, 50),
                        ),
                        onPressed: () async {
                          final TimeOfDay? time = await showCustomTimePicker(
                            context: context,
                            initialTime: selectedStartTime ?? TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              selectedStartTime = time;
                              LectureStartTimeController.text = '${selectedStartTime!.hour}:${selectedStartTime!.minute}';
                            });
                          }
                        },
                        child: const Text(
                          '강의 시작 시간',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 8,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                            letterSpacing: -0.14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row( // 강의 종료 시간
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5 - 150,
                      ),
                      Text(
                        // ignore: unnecessary_null_comparison
                        selectedEndTime != null
                            ? '${selectedEndTime!.hour}:${selectedEndTime!.minute}'
                            : '강의 종료 시간을 선택하세요',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 10,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(100, 50),
                        ),
                        onPressed: () async {
                          final TimeOfDay? time = await showCustomTimePicker(
                            context: context,
                            initialTime: selectedEndTime ?? TimeOfDay.now(),
                          );
                          setState(() {
                            selectedEndTime = time;
                            LectureEndTimeController.text = '${selectedEndTime!.hour}:${selectedEndTime!.minute}';
                          });
                        },
                        child: const Text(
                          '강의 종료 시간',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 8,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                            letterSpacing: -0.14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row( // 건물
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.5 - 150,
                    ),
                    Container(
                        width: 300,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 12,
                              offset: Offset(2, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: DropdownButton<String>(
                          value: building,
                          onChanged: (String? newValue) {
                            setState(() {
                              building = newValue!;
                              BuildingController.text = newValue;
                            });
                          },
                          underline: Container(),
                          // 선택 박스 배경색 흰색으로 변경
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          items: ['건물을 선택하세요', '전정대', '예디대']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  color: Color(0xFF3D3D3D),
                                  fontSize: 10,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                  height: 0.06,
                                  letterSpacing: -0.14,
                                ),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        )
                      
                    ),
                  ],
                  ),
                  const SizedBox(height: 20),
                  Row( // 비밀 번호
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.5 - 150,
                    ),
                    Container(
                        width: 300,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 12,
                              offset: Offset(2, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: TextField(
                                  controller: PasswordController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF3D3D3D),
                                        fontSize: 10,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w400,
                                        height: 0.06,
                                        letterSpacing: -0.14,
                                      )),
                                  style: const TextStyle(
                                    color: Color(0xFF3D3D3D),
                                    fontSize: 10,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                              ),
                            ),
                      
                    ),
                  ],
                  ),
                  const SizedBox(height: 40),
                  Positioned( // 생성하기!
                    left: screenSize.width * 0.55,
                    top: 800,
                    child: Container(
                      width: 100,
                      height: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color.fromARGB(255, 77, 75, 75),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 12,
                            offset: Offset(2, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: 
                              () {
                                _SendLectureData(LectureNameController, LectureDayController, LectureStartTimeController, LectureEndTimeController, BuildingController, PasswordController);
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size(100, 50),
                            ),
                            child: const DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            ),
                            child: Text(
                              '생성하기!',
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                ],
              ),
            ),
    );
  }
}

