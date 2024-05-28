import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/find-password-page.dart';
import 'package:profpilot/view/desktop-web/login-page.dart';
import 'package:profpilot/main.dart';
import 'package:profpilot/view/mobile-web/M-find-password-page.dart';
import 'package:profpilot/view/mobile-web/M-login-page.dart';

class SignupPageMobile extends StatefulWidget {
  const SignupPageMobile({super.key});

  @override
  State<SignupPageMobile> createState() => _SignupPageMobileState();
}

class _SignupPageMobileState extends State<SignupPageMobile> {
  bool _passwordsMatch() {
    return passwordController1.text == passwordController2.text;
  }

  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  String selectedDomain = '도메인을 선택하세요'; // 기본값 설정

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
                    left: 10,
                    right: 10,
                    bottom: 10,
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
              const SizedBox(height: 30),
              Positioned( // 환영합니다. 🦕
                left: screenSize.width * 0.1,
                top: screenSize.height * 0.1,
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 130, 195),
                    fontSize: 20,
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
              const SizedBox(height: 30),
              Positioned( // 새로운 친구는 언제나 환영이죠!
                left: screenSize.width * 0.1,
                top: screenSize.height * 0.13,
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
              const SizedBox(height: 50),
              Positioned( // 로그인, 비밀번호를 잃어버리셨습니까?
                left: screenSize.width * 0.1,
                top: screenSize.height * 0.15,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                            fontSize: 10,
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    breakpointName == 'MOBILE'
                                        ? FindPasswordPageMobile()
                                        : FindPasswordPage()
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
              const SizedBox(height: 100),
              Row( // 이메일
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.35,
                      height: screenSize.height * 0.04,
                      padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
                        // autofocus: true,
                        obscureText: false,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '이메일',
                          hintStyle: TextStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 10,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.3,
                            letterSpacing: -0.14,
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 10,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.1,
                          letterSpacing: -0.14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'BMHANNAPro',
                        fontWeight: FontWeight.w400,
                        height: 0.006,
                        letterSpacing: -0.14,
                      ),
                      child: Text('@'),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: screenSize.width * 0.35,
                      height: screenSize.height * 0.04,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        items: ['도메인을 선택하세요', 'khu.ac.kr']
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
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Row( // 이메일 인증 번호
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenSize.width * 0.35,
                    height: screenSize.height * 0.04,
                    padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
                                      fontSize: 10,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                      height: 0.06,
                                      letterSpacing: -0.14,
                                    )),
                                style: TextStyle(
                                  color: Color(0xFF3D3D3D),
                                  fontSize: 10,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                  height: 0.06,
                                  letterSpacing: -0.14,
                                ))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
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
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'BMHANNAPro',
                        fontWeight: FontWeight.w400,
                        height: 0.04,
                        letterSpacing: -0.12,
                      ),
                      child: Text('인증 확인'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Positioned( // 이름
                child: Container(
                  width: screenSize.width * 0.35,
                  height: screenSize.height * 0.04,
                  padding:
                      const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
                                    fontSize: 10,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 10,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              ))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Positioned(
                // 비밀번호
                child: Container(
                  width: screenSize.width * 0.35,
                  height: screenSize.height * 0.04,
                  padding:
                      const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
                              ))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Positioned(
                // 비밀번호 확인
                child: Container(
                  width: screenSize.width * 0.35,
                  height: screenSize.height * 0.04,
                  padding:
                      const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
                              fontSize: 10,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            ),
                          ),
                          style: TextStyle(
                            color:
                                _passwordsMatch() ? Colors.green : Colors.red,
                            fontSize: 10,
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
              const SizedBox(height: 20),
              Positioned(
                child: Container(
                  width: screenSize.width * 0.35,
                  height: screenSize.height * 0.04,
                  padding:
                      const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
                                    fontSize: 10,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                    height: 0.06,
                                    letterSpacing: -0.14,
                                  )),
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 10,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.06,
                                letterSpacing: -0.14,
                              ))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
