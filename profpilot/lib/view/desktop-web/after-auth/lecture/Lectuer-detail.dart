import 'dart:html';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:profpilot/DTO/mainpage-dto.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-page.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';

class LectureDetailPage extends StatefulWidget {
  final String lectureId;

  const LectureDetailPage({Key? key, required this.lectureId}) : super(key: key);

  @override
  State<LectureDetailPage> createState() => _LectureDetailPageState();
}

class _LectureDetailPageState extends State<LectureDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _lectureIdController = TextEditingController();
  final TextEditingController _lecturePasswordController = TextEditingController();

  Future<MainPageDTO> _initPageController() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return Future.error('로그인이 필요합니다.');
    }

    final Dio dio = Dio();
    try {
      final Response response = await dio.get('http://localhost:8080/main/page',
          options: Options(
            headers: {
              'access': accessToken,
            },
            extra: {
              'withCredentials': true,
            },
          ));
      return MainPageDTO.fromJson(response.data);
    } catch (e) {
      print(e);
      return Future.error('데이터를 불러오는 중 오류가 발생했습니다.');
    }
  }

  Future<void> _generateLecture() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return;
    }

    final Dio dio = Dio();
    try {
      final Response response = await dio.post(
        'http://localhost:8080/lecture/generate',
        options: Options(
          headers: {
            'access': accessToken,
          },
          extra: {
            'withCredentials': true,
          },
        ),
        data: {
          'lectureId': _lectureIdController.text,
          'lecturePassword': _lecturePasswordController.text,
        },
      );
      if (response.statusCode == 200) {
        print("response : " + response.data.toString());
        if (response.data["response"] == "success") {
          window.alert('수업이 생성되었습니다.');
        } else if (response.data["response"] == "not lecture time") {
          window.alert('수업 시간이 아닙니다.');
        } else if (response.data["response"] == "not this lecture professor") {
          window.alert('해당 강의의 교수님이 아닙니다.');
        } else if (response.data["response"] == "don't have lecture") {
          window.alert('해당 강의가 존재하지 않습니다.');
        } else {
          window.alert('교수님이 아닙니다.');
        }
      } else {
        window.alert('수업 생성에 실패했습니다.');
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: FutureBuilder<MainPageDTO>(
          future: _initPageController(),
          builder: (BuildContext context, AsyncSnapshot<MainPageDTO> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } 
            MainPageDTO data = snapshot.data!;
            // print(data.mainPageDTOList);
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(color: Color(0xFF444444)),
                  child: Column(
                    children: [
                      Positioned(
                        // 헤더
                        left: 0,
                        top: 0,
                        child: Container(
                          width: screenSize.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.800000011920929),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                  width: 20), // 왼쪽 여백을 만들기 위해 SizedBox를 사용합니다.
                              const Text(
                                '프로프파일럿',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'AppleSDGothicNeo',
                                  fontWeight: FontWeight.w400,
                                  height: 0.04,
                                  letterSpacing: -0.12,
                                ),
                              ),
                              const Spacer(), // 중간에 공간을 만들기 위해 Spacer를 사용합니다.
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainPage()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      '수업',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'AppleSDGothicNeo',
                                        fontWeight: FontWeight.w400,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          50), // 각 위젯 사이의 간격 조정을 위해 SizedBox를 사용합니다.
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PersonalMainPage()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      '내 정보',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'AppleSDGothicNeo',
                                        fontWeight: FontWeight.w400,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(), // 프로프파일럿과 수업&내정보 사이의 공간을 만들기 위해 Spacer를 사용합니다.
                              const Text(
                                '로그아웃',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'AppleSDGothicNeo',
                                  fontWeight: FontWeight.w400,
                                  height: 0.04,
                                  letterSpacing: -0.12,
                                ),
                              ),
                              const SizedBox(
                                  width: 20), // 오른쪽 여백을 만들기 위해 SizedBox를 사용합니다.
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 200,
                          ),
                          Positioned(
                            // 안녕하세요. 🐋
                            left: 193,
                            top: 152,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '안녕하세요.',
                                    style: TextStyle(
                                      color: Color(0xFF9F9F9F),
                                      fontSize: 15,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                      height: 0.02,
                                      letterSpacing: -0.14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\u{1FAE0}',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 237, 255, 75),
                                      fontSize: 15,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                      height: 0.02,
                                      letterSpacing: -0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 200,
                          ),
                          Positioned(
                            // 오늘은 N개의 수업이 있습니다.
                            left: 193,
                            top: 221,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '오늘은 ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                      height: 0.02,
                                      letterSpacing: -0.14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.lecturesSize.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                      height: 0.02,
                                      letterSpacing: -0.14,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '개의 수업이 있습니다.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                      height: 0.02,
                                      letterSpacing: -0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(color: Color(0xFF444444)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: data.mainPageDTOList.map((lecture) {
                        return 
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LectureDetailPage(lectureId: lecture.lectureId),
                              ),
                            );
                          },
                          child: Container(
                            width: 300,
                            height: 200,
                            margin: const EdgeInsets.only(left: 300, right: 100),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.black.withOpacity(0.800000011920929),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 12,
                                  offset: Offset(2, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      lecture.lectureName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      '교수님: ${lecture.lectureProfessor}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      '강의 요일: ${lecture.lectureDay.substring(1, lecture.lectureDay.length - 1)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      '강의 시작 시간: ${lecture.lectureStartTime}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      '강의 건물: ${lecture.lectureBuilding}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      '강의실: ${lecture.lectureRoom}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                        }
                      ).toList(),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.6),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          _generateLecture();
                        },
                        child: const Text(
                          '수업 생성',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.02,
                            letterSpacing: -0.14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        child: const Text(
                          '출석 체크',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.02,
                            letterSpacing: -0.14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        child: const Text(
                          '강의 입장',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.02,
                            letterSpacing: -0.14,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }
}
