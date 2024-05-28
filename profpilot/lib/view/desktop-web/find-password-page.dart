import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/login-page.dart';
import 'package:profpilot/view/desktop-web/signup-page.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({super.key});

  @override
  State<FindPasswordPage> createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF444444)),
          child: Stack(
            children: [
              Positioned(
                // 이런!
                left: screenSize.width * 0.1,
                top: 152,
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Color.fromARGB(255, 62, 158, 163),
                    fontSize: 48,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '이런! 🦘비밀번호를 잊으셨나요? ',
                  ),
                ),
              ),
              Positioned(
                // 비밀번호를 잊으셨나요?
                left: screenSize.width * 0.1,
                top: 221,
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.02,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '등록하신 이메일로 새로운 비밀번호를 보내드릴게요.',
                  ),
                ),
              ),
              Positioned(
                // 비밀번호 찾기
                left: screenSize.width * 0.5 - 100,
                width: 200,
                top: 478,
                child: const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '비밀번호 찾기',
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
                    bottom: 30,
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
              Positioned(
                // 로그인, 비밀번호를 잃어버리셨습니까?
                left: screenSize.width * 0.5 - 300,
                top: 649,
                child: Container(
                  width: 600,
                  height: 60,
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
                                builder: (context) => const LoginPage()),
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
                            height: 0,
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
                                builder: (context) => const SignupPage()),
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
              Positioned(
                // 이메일
                left: screenSize.width * 0.5 - 300,
                top: 530,
                child: Container(
                  width: 600,
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
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
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 30,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                        ),
                        child: Text('이메일'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
