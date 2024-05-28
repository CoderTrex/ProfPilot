import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/login-page.dart';
import 'package:profpilot/view/desktop-web/signup-page.dart';
import 'package:profpilot/main.dart';
import 'package:profpilot/view/mobile-web/M-login-page.dart';
import 'package:profpilot/view/mobile-web/M-signup-page.dart';

class FindPasswordPageMobile extends StatefulWidget {
  const FindPasswordPageMobile({super.key});

  @override
  State<FindPasswordPageMobile> createState() => _FindPasswordPageMobileState();
}

class _FindPasswordPageMobileState extends State<FindPasswordPageMobile> {
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
          child: Column(
            children: [
              Positioned( // 헤더
                child: Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 10,
                    right: 10,
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
                          height: 0.04,
                          letterSpacing: -0.12,
                        ),
                        child: Text(
                          '프로프파일럿',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container( // 이런!
                alignment: const Alignment(-0.7, 0), 
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '이런!',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container( // 비밀번호를 잊으셨나요?
                alignment: const Alignment(-0.30, 0),
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '비밀번호를 잊으셨나요?',
                  ),
                ),
              ),
              // 화면의 1/3만큼 띄워줌
              SizedBox(height: screenSize.height * 0.3),
              Positioned( // 로그인, 회원가입 버튼
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.05,
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
                                        ? const LoginPageMobile()
                                        : const LoginPage()
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
                            fontSize: 10,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: -0.12,
                          ),
                          child: Text(
                            '로그인',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    breakpointName == 'MOBILE'
                                        ? const SignupPageMobile()
                                        : const SignupPage()
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
                            fontSize: 10,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: -0.12,
                          ),
                          child: Text('회원가입'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Positioned( // 이메일
                child: Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.05,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                                  hintText: '이메일 주소를 입력해주세요',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF3D3D3D),
                                    fontSize: 12,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 12,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              ))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Positioned( // 가입하기!
                child: Container(
                  width: screenSize.width * 0.35,
                  height: screenSize.height * 0.04,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(255, 77, 75, 75),
                    shape: RoundedRectangleBorder(
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x14000000),
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
                          fontSize: 20,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                        ),
                        child: Text(
                          '비밀번호 찾기',
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
