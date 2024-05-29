
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:profpilot/DTO/mypage-dto.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/my-edit.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';

class MyPage extends StatefulWidget {

  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final PageController _pageController = PageController();

  Future<MyPageDTO> _initPageController() async {
    final String? accessToken = window.localStorage['token'];
    final MyPageDTO myPageDTO;
    
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
        'http://localhost:8080/member/my-page',
        options: Options(
          headers: {
            'access': accessToken,
          },
        ),
      );
      MyPageDTO myPageDTO = MyPageDTO.fromResponse(response);
      return myPageDTO;
    } catch (e) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const LoginPage()
        )
      );
    }
    return MyPageDTO.empty();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final MyPageDTO myPageDTO = MyPageDTO.empty();

    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: FutureBuilder<MyPageDTO>(
        future: _initPageController(),
        builder: (BuildContext context, AsyncSnapshot<MyPageDTO> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            MyPageDTO myPageDTO = snapshot.data!;
            if (myPageDTO.email == '') {
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
                decoration: const BoxDecoration(color: Color(0xFF444444)),
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
                                        builder: (context) => MyPage()
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
                    const SizedBox(height: 100),
                    const Positioned( // 안녕하세요. 🐋
                      child: Row(children: [
                        SizedBox(width: 200),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '개인정보 공유 X ',
                                style: TextStyle(
                                  color: Color(0xFF9F9F9F),
                                  fontSize: 48,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                  height: 0.02,
                                  letterSpacing: -0.14,
                                ),
                              ),
                              TextSpan(
                                text: '🐋',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 87, 117, 180),
                                  fontSize: 48,
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
                    const SizedBox(height: 70),
                    const Positioned(
                      child: Row (children: [
                        SizedBox(width: 200),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '프로프파일럿내의 정보는 제 3자에게 공유되지 않습니다.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
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
                    const SizedBox(height: 150),
                    Container(
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(color: Color(0xFF444444)),
                      child: Row(
                        children: [
                          const SizedBox(width: 200),
                          Center(
                            child: GestureDetector (
                              // onTap: () {
                              //   showCupertinoDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return Container(
                              //         height: screenSize.height * 0.8,
                              //         width: screenSize.width * 0.8,
                              //         decoration: const BoxDecoration(
                              //           color: Color.fromARGB(255, 0, 0, 0),
                              //           borderRadius: BorderRadius.only(
                              //             topLeft: Radius.circular(20),
                              //             topRight: Radius.circular(20),
                              //           ),
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: Colors.black26,
                              //               blurRadius: 10,
                              //               offset: Offset(0, -2),
                              //             ),
                              //           ],
                              //         ),
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           children: [
                              //             const DefaultTextStyle(
                              //               style: TextStyle(
                              //                 color: Colors.white,
                              //                 fontSize: 20,
                              //                 fontFamily: 'inter',
                              //                 fontWeight: FontWeight.w400,
                              //                 height: 0.04,
                              //                 letterSpacing: -0.12,
                              //               ),                                     
                              //               child: Column(
                              //                 children: [
                              //                   SizedBox(height: 20),
                              //                   Text(
                              //                     '내 정보',
                              //                   ),
                              //                   SizedBox(height: 20),
                              //                   Text(
                              //                     '이메일',
                              //                   ),
                              //                   SizedBox(height: 20),
                              //                   Text(
                              //                     '이름',
                              //                   ),
                              //                   SizedBox(height: 20),
                              //                   Text(
                              //                     '학번',
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             const SizedBox(height: 20),
                              //             ElevatedButton(
                              //               onPressed: () {
                              //                 Navigator.of(context).pop();
                              //               },
                              //               child: const Text('Close'),
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //   );
                              // },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PersonalEditPage()),
                              );
                            },
                            child: Container(
                              width: 400,
                              height: 300,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/apple.png'),
                                  fit: BoxFit.cover,
                                ),
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
                                  const SizedBox(height: 40),
                                  const Row(
                                    children: [
                                    SizedBox(width: 30),
                                    Text(
                                      '내 정보',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    ]
                                  ),
                                  const SizedBox(height: 150),
                                  Row(children: [ // 이메일
                                    const SizedBox(width: 30),
                                    const Text(
                                        "이메일",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      snapshot.data!.email,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                  ],),
                                  const SizedBox(height: 30),
                                  Row(children: [ // 이름
                                    const SizedBox(width: 30),
                                    const Text(
                                      '이름',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    const SizedBox(width: 35),
                                    Text(
                                      snapshot.data!.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                  ],),
                                  const SizedBox(height: 30),
                                  Row(children: [ // 학번
                                    const SizedBox(width: 30),
                                    const Text(
                                      '학번',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w100,
                                        height: 0.04,
                                        letterSpacing: -0.12,
                                      ),
                                    ),
                                    const SizedBox(width: 35),
                                    Text(
                                      snapshot.data!.studentId,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
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
                          Center(
                            child: GestureDetector (
                              onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Modal Title'),
                                    content: Text('This is the content of the modal.'),
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
                                width: 400,
                                height: 300,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/apple2.png'),
                                    fit: BoxFit.cover,
                                  ),
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
                                    const SizedBox(height: 40),
                                    const Row(
                                      children: [
                                      SizedBox(width: 30),
                                      Text(
                                        '맴버쉽 및 권한 관리',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w400,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      ]
                                    ),
                                    const SizedBox(height: 150),
                                    Row(children: [ // 이메일
                                      const SizedBox(width: 30),
                                      const Text(
                                        "역할",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      const SizedBox(width: 80),
                                      Text(
                                        snapshot.data!.role,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                    ],),
                                    const SizedBox(height: 30),
                                    Row(children: [ // 이름
                                      const SizedBox(width: 30),
                                      const Text(
                                        '맴버쉽 등급',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      const SizedBox(width: 35),
                                      Text(
                                        snapshot.data!.membershipGrade,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                    ],),
                                    const SizedBox(height: 30),
                                    Row(children: [ // 학번
                                      const SizedBox(width: 30),
                                      const Text(
                                        '클라우드 관리',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w100,
                                          height: 0.04,
                                          letterSpacing: -0.12,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        snapshot.data!.cloudGrade,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
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