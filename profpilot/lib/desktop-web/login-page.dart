import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:profpilot/desktop-web/find-password-page.dart';
import 'package:profpilot/desktop-web/signup-page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Cookie cookie = Cookie('JSESSIONID', '1234');
  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showAboutDialog(context: context, children: const [
        Text('이메일과 비밀번호를 입력해주세요.'),
      ]);
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:8080/member/login'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    print(response.body);
  }


  @override
  Widget build(BuildContext context) {
    _emailController.text = 'silvercaslte@khu.ac.kr';
    _passwordController.text = '1234';
    final Size screenSize = MediaQuery.of(context).size;
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
                Positioned(                  // 안녕하세요.👋
                  left: screenSize.width / 2 - 500,
                  top: 152,
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      color: Color.fromARGB(255, 92, 145, 175),
                      fontSize: 48,
                      fontFamily: 'BMHANNAPro',
                      fontWeight: FontWeight.w400,
                      height: 0.02,
                      letterSpacing: -0.14,
                    ),
                    child: Text('안녕하세요. \u{1F44B}'),
                  ),
                ),
                Positioned(                  // 프로프파일럿에 오신 걸 환영합니다.
                  left: screenSize.width / 2 - 500,
                  top: 221,
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      color: Color.fromARGB(255, 216, 216, 216),
                      fontSize: 48,
                      fontFamily: 'BMHANNAPro',
                      fontWeight: FontWeight.w400,
                      height: 0.02,
                      letterSpacing: -0.14,
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '프로프파일럿에 오신 걸 환영합니다.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(                  // 프로프파일럿에 로그인
                  left: screenSize.width / 2 - 100,
                  top: 443,
                  child: const SizedBox(
                    width: 200,
                    height: 52,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontSize: 20,
                        fontFamily: 'BMHANNAPro',
                        fontWeight: FontWeight.w400,
                        height: 0.13,
                        letterSpacing: -0.14,
                      ),
                      child: Text('프로프파일럿에 로그인'),
                    ),
                  ),
                ),
                Positioned(                  // 헤더
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
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                            letterSpacing: -0.12,
                          ),
                          child: Text('프로프파일럿 \u{2708}'),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(                  // 회원 가입, 비밀번호를 잊으셨나요?
                  left: screenSize.width / 2 - 300,
                  top: 900,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 61, vertical: 14),
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
                                  builder: (context) => const SignupPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, // 배경색 투명
                            shadowColor: Colors.transparent, // 그림자 투명
                            minimumSize: const Size(100, 60),
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
                            child: Text('회원가입'),
                          ),
                        ),
                        const SizedBox(width: 134),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FindPasswordPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(100, 60),
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
                Positioned(                  // 이메일
                  left: screenSize.width / 2 - 300,
                  top: 500,
                  child: Container(
                    width: 600,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '이메일',
                              hintStyle: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 25,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.14,
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(                  // 비밀번호
                  left: screenSize.width / 2 - 300,
                  top: 623,
                  child: Container(
                    width: 600,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '비밀번호',
                              hintStyle: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 25,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.14,
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenSize.width / 2 - 100,
                  top: 750,
                  child: Container(
                    width: 200,
                    height: 40,
                    // padding: const EdgeInsets.only(left: 48, right: 46),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.black,
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
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(200, 40),
                          ),
                          child: const Text(
                            '입장하기!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
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
        ],
      ),
    );
  }
}