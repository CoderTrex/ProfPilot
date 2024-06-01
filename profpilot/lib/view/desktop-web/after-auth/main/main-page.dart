import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:profpilot/DTO/mainpage-dto.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/lecture-gen.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-page.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _lectureIdController = TextEditingController();
  final TextEditingController _lecturePasswordController =
      TextEditingController();

  Future<MainPageDTO> _initPageController() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
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

      print(response.data);
      return MainPageDTO.empty();
    } catch (e) {
      print(e);
      return MainPageDTO.empty();
    }
  }

  Future<void> _GenerateLecture() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    final Dio dio = Dio();

    try {
      final Response response = await dio.get(
        'http://localhost:8080/WhoAmI',
        options: Options(
          headers: {
            'access': accessToken,
          },
          extra: {
            'withCredentials': true,
          },
        ),
      );
      if (response.data != 'ROLE_PROFESSOR') {
        window.alert('수업 생성 권한이 없습니다.');
        return;
      }
    } catch (e) {
      print(e);
    }

    if (accessToken != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LectureGeneratePage()));
    }
  }

  Future<void> _addLecture() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    final Dio dio = Dio();

    try {
      final Response response = await dio.post(
        'http://localhost:8080/lecture/Enrolment',
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
          'password': _lecturePasswordController.text,
        },
      );

      if (response.data == 'success') {
        window.alert('수업 등록에 성공했습니다.');
      } else {
        window.alert('수업 등록에 실패했습니다.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onSearchIconPressed() async {
    String searchText = _searchController.text;

    String accessToken = window.localStorage['token'] ?? '';

    if (accessToken.isEmpty) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return;
    }

    final Dio dio = Dio();
    try {
      final response = await dio.post(
        'http://localhost:8080/lecture/search',
        options: Options(
          headers: {
            'access': accessToken,
          },
          extra: {
            'withCredentials': true,
          },
        ),
        data: {
          'searchText': searchText,
        },
      );

      var data = response.data;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('검색 결과'),
            content: Container(
              width: 700,
              height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('검색어: $searchText'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var lecture = data[index]; // 인덱스로 접근
                        return Card(
                          child: ListTile(
                            title: Text(lecture['lectureName'].toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                )),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '요일: ${lecture['day'].substring(1, lecture['day'].length - 1)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text('강의 시작 시간: ${lecture['startTime']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(width: 10),
                                Text('강의 종료 시간: ${lecture['endTime']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(width: 10),
                                Text('건물: ${lecture['building']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(width: 10),
                                Text('강의실: ${lecture['room']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(width: 10),
                                Text('교수: ${lecture['professorName']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('강좌 등록'),
                                    content: Container(
                                      width: 300,
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                              '${lecture['lectureName']} 등록하시겠습니까?'),
                                          const SizedBox(height: 30),
                                          TextField(
                                            controller:
                                                _lecturePasswordController,
                                            decoration: const InputDecoration(
                                              labelText: '비밀번호',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('아니오'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _lectureIdController.text =
                                              lecture['lectureId'];
                                          _addLecture();
                                        },
                                        child: Text('예'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('닫기'),
              ),
            ],
          );
        },
      );
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
          builder: (context, snapshot) {
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
                      Row(
                        children: [
                          // 강의 검색
                          SizedBox(
                            width: screenSize.width - 350,
                          ),
                          Container(
                            width: 300,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0x19D9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: '강의 검색',
                                hintStyle: const TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontSize: 15,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                  height: 0.04,
                                  letterSpacing: -0.12,
                                ),
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  color: const Color(0xFFD9D9D9),
                                  onPressed:
                                      _onSearchIconPressed, // 검색 아이콘을 눌렀을 때 호출되는 함수
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
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
                      const Row(
                        children: [
                          SizedBox(
                            width: 200,
                          ),
                          const Positioned(
                            // 오늘은 N개의 수업이 있습니다.
                            left: 193,
                            top: 221,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
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
                                    text: 'N',
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
                    controller: _pageController,
                    scrollDirection: Axis.horizontal, // 수평 스크롤 설정
                    child: Row(
                      children: List.generate(10, (index) {
                        final random = Random();
                        final double x =
                            random.nextDouble() * 2 - 1; // -1.0 ~ 1.0 사이의 값
                        final double y =
                            random.nextDouble() * 2 - 1; // -1.0 ~ 1.0 사이의 값
                        return Container(
                          width: 200, // 적절한 너비 설정
                          height: 200, // 적절한 높이 설정
                          margin: const EdgeInsets.only(
                              left: 300, right: 100), // 적절한 마진 설정
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              image: const AssetImage(
                                  'assets/images/apple-wallpaper.jpg'),
                              alignment: Alignment(x, y), // 랜덤한 위치 설정
                              fit: BoxFit.none, // 이미지의 원래 크기를 유지
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 12,
                                offset: Offset(2, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.8),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _GenerateLecture,
                        child: const Text(
                          '강의 생성',
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
                )
              ],
            );
          }),
    );
  }
}
