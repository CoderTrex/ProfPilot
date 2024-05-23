import 'package:flutter/material.dart';
import 'package:profpilot/desktop-web/find-password-page.dart';
import 'package:profpilot/desktop-web/login-page.dart';
import 'package:profpilot/main.dart';
import 'package:profpilot/mobile-web/M-login-page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  bool _passwordsMatch() {
    return passwordController1.text == passwordController2.text;
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  String selectedDomain = '도메인을 선택하세요'; // 기본값 설정

  String _responseText = 'Waiting for response...';

  Future<void> _SendVerifyEmail() async {
    final response = await http.get(Uri.parse('http://localhost:8080/signup/email/verify?email=${emailController.text}'));
    if (response.statusCode == 200) {
      setState(() {
        _responseText = response.body;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    String breakpointName = getBreakpointName(screenSize.width);
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFF444444)),
          child: Stack(
            children: [
              const Positioned(
                // 환영합니다. 🦕
                left: 76,
                top: 428,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 130, 195),
                    fontSize: 48,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '환영합니다. \u{1F995}',
                  ),
                ),
              ),
              const Positioned(
                // 새로운 친구는 언제나 환영이죠!
                left: 76,
                top: 495,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '새로운 친구는 언제나 환영이죠!',
                  ),
                ),
              ),
              Positioned(
                // 헤더
                left: 0,
                top: 0,
                child: Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.800000011920929),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: -0.14,
                        ),
                        child: Text(
                          '프로프파일럿',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // 로그인, 비밀번호를 잃어버리셨습니까?
                left: 70,
                top: 623,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 61, vertical: 14),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    breakpointName == 'MOBILE'
                                        ? LoginPageMobile()
                                        : LoginPage()
                                        ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                            letterSpacing: -0.12,
                          ),
                          child: Text(
                            '로그인',
                          ),
                        ),
                      ),
                      const SizedBox(width: 134),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FindPasswordPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                            letterSpacing: -0.12,
                          ),
                          child: Text(
                            '비밀번호를 잃어버리셨습니까?',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // 이메일
                left: screenSize.width * 0.55,
                top: 200,
                child: Container(
                  width: screenSize.width * 0.2,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '이메일',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF3D3D3D),
                                    fontSize: 25,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 25,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              )))
                    ],
                  ),
                ),
              ),
              Positioned(
                // @
                left: screenSize.width * 0.76,
                top: 250,
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.006,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '@',
                  ),
                ),
              ),
              Positioned( // 도메인
                  left: screenSize.width * 0.78,
                  top: 200,
                  child: Container(
                      width: screenSize.width * 0.1,
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
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
                        value: selectedDomain,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDomain = newValue!;
                          });
                        },
                        underline: Container(),
                        // 선택 박스 배경색 흰색으로 변경
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        items: ['도메인을 선택하세요', 'khu.ac.kr']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 16,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              ),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ))),
              Positioned( // 인증 메일 전송
                left: screenSize.width * 0.9,
                top: 200,
                child: Container(
                  width: screenSize.width * 0.08,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 94, 92, 92),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _SendVerifyEmail();   
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          minimumSize: const Size(100, 50),
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                            letterSpacing: -0.12,
                          ),
                          child: Text(
                            '인증 메일 전송',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Positioned(
                // 이메일 인증
                left: screenSize.width * 0.55,
                top: 300,
                child: Container(
                  width: screenSize.width * 0.2,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '이메일 인증 번호',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF3D3D3D),
                                    fontSize: 25,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 25,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              )))
                    ],
                  ),
                ),
              ),
              Positioned( // 인증 확인
                left: screenSize.width * 0.78,
                top: 300,
                child: Container(
                  width: screenSize.width * 0.08,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 94, 92, 92),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FindPasswordPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          minimumSize: const Size(100, 50),
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                            letterSpacing: -0.12,
                          ),
                          child: Text(
                            '인증 확인',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // 이름
                left: screenSize.width * 0.55,
                top: 400,
                child: Container(
                  width: screenSize.width * 0.2,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '이름',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF3D3D3D),
                                    fontSize: 25,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 25,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              ))),
                    ],
                  ),
                ),
              ),
              Positioned(
                // 비밀번호
                left: screenSize.width * 0.55,
                top: 500,
                child: Container(
                  width: screenSize.width * 0.2,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                              controller: passwordController1,
                              obscureText: false,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '비밀번호',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF3D3D3D),
                                    fontSize: 25,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: const TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 25,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              ))),
                    ],
                  ),
                ),
              ),
              Positioned(
                // 비밀번호 확인
                left: screenSize.width * 0.55,
                top: 600,
                child: Container(
                  width: screenSize.width * 0.2,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: passwordController2,
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '비밀번호 확인',
                            hintStyle: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            ),
                          ),
                          style: TextStyle(
                            color:
                                _passwordsMatch() ? Colors.green : Colors.red,
                            fontSize: 25,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                            letterSpacing: -0.14,
                          ),
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // 학번
                left: screenSize.width * 0.55,
                top: 700,
                child: Container(
                  width: screenSize.width * 0.2,
                  height: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '학번',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF3D3D3D),
                                    fontSize: 25,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 25,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              ))),
                    ],
                  ),
                ),
              ),
              Positioned(
                // 가입하기!
                left: screenSize.width * 0.6,
                top: 900,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 48),
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                        ),
                        child: Text(
                          '가입하기!',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

