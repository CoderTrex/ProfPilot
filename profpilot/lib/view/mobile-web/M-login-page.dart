import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/find-password-page.dart';
import 'package:profpilot/main.dart';
import 'package:profpilot/view/mobile-web/M-find-password-page.dart';
import 'package:profpilot/view/mobile-web/M-signup-page.dart';

class LoginPageMobile extends StatefulWidget {
  const LoginPageMobile({super.key});
  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
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
                Positioned( // 안녕하세요.👋
                  left: screenSize.width *0.1,
                  top: screenSize.height *0.2,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Color.fromARGB(255, 92, 145, 175),
                      fontSize: 20,
                      fontFamily: 'BMHANNAPro',
                      fontWeight: FontWeight.w400,
                      height: 0.02,
                      letterSpacing: -0.14,
                    ),
                    child: Text('안녕하세요. \u{1F44B}'),
                  ),
                ),
                Positioned( // 프로프파일럿에 오신 걸 환영합니다.
                  left: screenSize.width *0.1,
                  top: screenSize.height *0.23,
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      color: Color.fromARGB(255, 216, 216, 216),
                      fontSize: 20,
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
                Positioned( // 헤더
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
                            height: 0.04,
                            letterSpacing: -0.12,
                          ),
                          child: Text('프로프파일럿 \u{2708}'),
                        ),
                      ],
                    ),
                  ),
                ),                
                Positioned( // 이메일
                  left: screenSize.width * 0.1,
                  top: screenSize.height * 0.6,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.05,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                    child: const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '이메일',
                              hintStyle: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 20,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                // letterSpacing: -0.14,
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 20,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.14,
                            ),
                          ),
                        ),
                      
                    
                  ),
                ),
                Positioned( // 비밀번호
                  left: screenSize.width * 0.1,
                  top: screenSize.height * 0.68,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.05,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '비밀번호',
                              hintStyle: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 20,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.14,
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 20,
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
                Center(
                  child: Positioned( // 회원 가입, 비밀번호를 잊으셨나요?
                    left: screenSize.width * 0.12,
                    top: screenSize.height * 0.8,
                    child: Container(
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 61, vertical: 14),
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
                                          ? const SignupPageMobile()
                                          : const SignupPageMobile(),
                                          ),
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
                                fontSize: 10,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                height: 0.04,
                                letterSpacing: -0.12,
                              ),
                              child: Text('회원가입'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      breakpointName == 'MOBILE'
                                          ? const FindPasswordPageMobile()
                                          : const FindPasswordPage()
                                          ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
