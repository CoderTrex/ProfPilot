
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:profpilot/DTO/msmain-dto.dart';
import 'package:profpilot/DTO/mypage-dto.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-edit.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-page.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';

class MemebershipMainPage extends StatefulWidget {

  const MemebershipMainPage({super.key});

  @override
  State<MemebershipMainPage> createState() => _MemebershipMainPageState();
}

class _MemebershipMainPageState extends State<MemebershipMainPage> {
  final PageController _pageController = PageController();

  Future<MsmainDTO> _initPageController() async {
    final String? accessToken = window.localStorage['token'];
    
    if (accessToken == null) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const LoginPage()
        )
      );
    }
    final dio = Dio();
    try {
      final response = await dio.get(
        'http://localhost:8080/member/my-membership',
        options: Options(
          headers: {
            'access': accessToken,
          },
        ),
      );
      MsmainDTO msmainDTO = MsmainDTO.fromResponse(response);
      return msmainDTO;
    } catch (e) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const LoginPage()
        )
      );
    }
    return MsmainDTO.empty();
  }

  Future<void> _applyProfessor(String apply) async {
    final String? accessToken = window.localStorage['token'];
    final dio = Dio();
    if (apply == "true") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('이미 교수 권한을 신청하셨습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
      return;
    }
    
    try {
      final response = await dio.post(
        'http://localhost:8080/member/apply-professor',
        options: Options(
          headers: {
            'access': accessToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data == "already") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('이미 교수 권한을 신청하셨습니다.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        }
        if (response.data == "success") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('교수 권한 신청이 완료되었습니다.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('교수 권한 신청에 실패했습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: FutureBuilder<MsmainDTO>(
        future: _initPageController(),
        builder: (BuildContext context, AsyncSnapshot<MsmainDTO> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          else if (snapshot.hasData) {
            MsmainDTO msmainDTO = snapshot.data!;
            if (msmainDTO.role.isEmpty) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              });
              return Container();
            }
          }
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color(0xFF444444),
                ),
                child: Column(
                  children: [
                    Positioned( // 헤더
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
                            const SizedBox(width: 20),
                            const Text(
                              '프로프파일럿',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'SF-Pro-Display',
                                fontWeight: FontWeight.w400,
                                height: 0.04,
                                letterSpacing: -0.12,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(
                                        builder: (context) => MainPage()
                                      )
                                    );
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
                                    fontFamily: 'SF-Pro-Display',
                                    fontWeight: FontWeight.w400,
                                    height: 0.04,
                                    letterSpacing: -0.12,
                                  ),
                                ),
                                ),
                                const SizedBox(width: 50),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(
                                        builder: (context) => const PersonalMainPage()
                                      )
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ), 
                                  child:const Text(
                                  '내 정보',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'SF-Pro-Display',
                                    fontWeight: FontWeight.w400,
                                    height: 0.04,
                                    letterSpacing: -0.12,
                                  ),
                                ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              '로그아웃',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'SF-Pro-Display',
                                fontWeight: FontWeight.w400,
                                height: 0.04,
                                letterSpacing: -0.12,
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Positioned( // 안녕하세요. 🐋
                      child: Row(children: [
                        SizedBox(width: 200),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '아직까지는 맴버쉽 서비스가 없어요..ㅠㅠ',
                                style: TextStyle(
                                  color: Color(0xFF9F9F9F),
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
                      ],),
                    ),
                    const SizedBox(height: 20),
                    const Positioned(
                      child: Row (children: [
                        SizedBox(width: 200),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '하지만, 시간이 지나면 맴버쉽 서비스가 생길 수 있겠죠?',
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
                      ],),
                    ),
                    const SizedBox(height: 100),
                    Container(
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(color: Colors.transparent),
                      child: Row(
                        children: [
                          SizedBox(width: screenSize.width * 0.5 - 350), 
                          Center( // 교수 권한 신청
                            child: GestureDetector (
                            onTap: () {
                              showDialog(
                                context: context,
                                
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: const Text(
                                      '교수가 되고 싶으신가요?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'BMHANNAPro',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _applyProfessor(snapshot.data!.professorAuthapply);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          '신청하기',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'BMHANNAPro',
                                            fontWeight: FontWeight.w100,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          '닫기',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'BMHANNAPro',
                                            fontWeight: FontWeight.w100,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x14000000),
                                    blurRadius: 12,
                                    offset: Offset(2, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  const Row(
                                    children: [
                                    SizedBox(width: 30),
                                    Text(
                                      '교수 권한 신청',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    ]
                                  ),
                                  const SizedBox(height: 100),
                                  Row(children: [ // 현재 역할
                                    const SizedBox(width: 30),
                                    const Text(
                                      "현재 역할",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    const SizedBox(width: 76),
                                    Text(
                                      snapshot.data!.role,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                  ],),
                                  const SizedBox(height: 15),
                                  Row(children: [ // 이름
                                    const SizedBox(width: 30),
                                    const Text(
                                      '교수 권한 신청 여부',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    const SizedBox(width: 35),
                                    Text(
                                      snapshot.data!.professorAuthapply.toLowerCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                  ],),
                                  const SizedBox(height: 15),
                                  Row(children: [ // 학번
                                    const SizedBox(width: 30),
                                    const Text(
                                      '교수 권한 허가 대학',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    const SizedBox(width: 35),
                                    Text(
                                      snapshot.data!.professorUniversity.toLowerCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                  ],),
                                ],
                              ),
                            ),
                          )
                        ),
                          const SizedBox(width: 100),
                          Center( // 맴버쉽 관리
                            child: GestureDetector (
                              onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      '맴버쉽은 아직 없어요!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    content: const Text(
                                      '시간이 지나면 맴버쉽 서비스가 생길 수 있겠죠?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: 
                              Container(
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 12,
                                      offset: Offset(2, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    const Row(
                                      children: [
                                      SizedBox(width: 30),
                                      Text(
                                        '맴버쉽 관리',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w400,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      ]
                                    ),
                                    const SizedBox(height: 100),
                                    Row(children: [ // 맴버쉽 등급
                                      const SizedBox(width: 30),
                                      const Text(
                                        "현재 맴버쉽 등급",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      const SizedBox(width: 38),
                                      Text(
                                        snapshot.data!.membershipGrade.toLowerCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                    ],),
                                    const SizedBox(height: 15),
                                    Row(children: [ // 맴버쉽 만료일
                                      const SizedBox(width: 30),
                                      const Text(
                                        '맴버쉽 만료일',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      const SizedBox(width: 50),
                                      Text(
                                        snapshot.data!.membershipGrade.toLowerCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                    ],),
                                    const SizedBox(height: 15),
                                    Row(children: [ // 클라우드 용량
                                      const SizedBox(width: 30),
                                      const Text(
                                        '클라우드 용량',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      const SizedBox(width: 50),
                                      Text(
                                        snapshot.data!.cloudCapacity.toLowerCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ],
                                ),
                              ),                          
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}