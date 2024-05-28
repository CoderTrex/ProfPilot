import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/find-password-page.dart';
import 'package:profpilot/view/desktop-web/login-page.dart';
import 'package:profpilot/main.dart';
import 'package:profpilot/view/mobile-web/M-login-page.dart';
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
  TextEditingController emailController       = TextEditingController();
  TextEditingController emailVerifyController = TextEditingController();
  TextEditingController nameController        = TextEditingController();
  TextEditingController passwordController1   = TextEditingController();
  TextEditingController passwordController2   = TextEditingController();
  TextEditingController studentIdController   = TextEditingController();

  String selectedDomain = '도메인을 선택하세요';
  // ignore: non_constant_identifier_names
  Future<void> _SendVerifyEmail() async {
    if (selectedDomain == '도메인을 선택하세요') {
      setState(() {
        showAboutDialog(context: context, applicationName: '에러.', children: [const Text('도메인을 선택하세요.')] );
      });
      return;
    }
    String fullEmail = '${emailController.text}@$selectedDomain';
    

    // 이메일 인증 요청을 보낼 때 CSRF 토큰을 함께 전송
    final response = await http.post(
      Uri.parse('http://localhost:8080/member/signup/email/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': fullEmail,
      }),
    );


    if (response.statusCode == 200) {
      if (response.body == 'success') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '성공', children: [const Text('성공적으로 이메일을 보냈습니다.')] );
      } else if (response.body == 'already') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '이미 인증됨', children: [const Text('이미 인증된 이메일입니다.')] );
      } else if (response.body == 'wait') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('5분 이내로 이미 전송된 이메일이 있습니다.')] );
      } else {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('이메일을 보내는데 실패했습니다.')] );
      }
      setState(() {
      });
    } else {
        // ignore: use_build_context_synchronously
      showAboutDialog(context: context, applicationName: '실패', children: [const Text('이메일을 보내는데 실패했습니다.')] );
      setState(() {
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> _CheckVerifyEmail() async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/member/signup/email/verify/check'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': '${emailController.text}@$selectedDomain',
        'verifyCode': emailVerifyController.text,
      }),
    );

    if (response.statusCode == 200) {
      if (response.body == 'success') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '성공', children: [const Text('성공적으로 인증되었습니다.')] );
      } else if (response.body == 'fail') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('인증에 실패했습니다.')] );
      } else if (response.body == 'notfound') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('가입창에 작성된 이메일과 일치하는 인증코드가 없습니다.')] );
      } else {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('인증에 실패했습니다.')] );
      }
      setState(() {
      });
    } else {
        // ignore: use_build_context_synchronously
      showAboutDialog(context: context, applicationName: '실패', children: [const Text('인증에 실패했습니다.')] );
      setState(() {
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> _SendSignup() async {
    final Size screenSize = MediaQuery.of(context).size;
    String breakpointName = getBreakpointName(screenSize.width);
    if (!_passwordsMatch()) {
      // ignore: use_build_context_synchronously
      showAboutDialog(context: context, applicationName: '실패', children: [const Text('비밀번호가 일치하지 않습니다.')] );
      return;
    }
    if (selectedDomain == '도메인을 선택하세요') {
      // ignore: use_build_context_synchronously
      showAboutDialog(context: context, applicationName: '실패', children: [const Text('도메인을 선택하세요.')] );
      return;
    }
    if (emailController.text == '' || emailVerifyController.text == '' || nameController.text == '' || passwordController1.text == '' || passwordController2.text == '' || studentIdController.text == '') {
      // ignore: use_build_context_synchronously
      showAboutDialog(context: context, applicationName: '실패', children: [const Text('모든 칸을 채워주세요.')] );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:8080/member/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': '${emailController.text}@$selectedDomain',
        'password': passwordController1.text,
        'name': nameController.text,
        'studentId': studentIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      if (response.body == 'success') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '성공', children: [const Text('성공적으로 가입되었습니다.')] );
        setState(() {
          MaterialPageRoute(builder: (context) => breakpointName == 'MOBILE' ? const LoginPageMobile() : const LoginPage());
        });
      } else if (response.body == 'fail') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('가입에 실패했습니다.')] );
      } else if (response.body == 'lack') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('모든 칸을 채워주세요.')] );
      } else if (response.body == 'already') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('이미 가입된 이메일입니다.')] );
      } else if (response.body == 'not-Verified') {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('이메일 인증을 완료해주세요.')] );
      } else {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, applicationName: '실패', children: [const Text('가입에 실패했습니다.')] );
      }
      setState(() {
      });
    } else {
      // ignore: use_build_context_synchronously
      showAboutDialog(context: context, applicationName: '실패', children: [const Text('가입에 실패했습니다.')] );
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    String breakpointName = getBreakpointName(screenSize.width);
    return Scaffold(
        body:
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
                  Positioned( // 로그인, 비밀번호를 잃어버리셨습니까?
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
                                    builder: (context) => const FindPasswordPage()),
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
                  Positioned( // 이메일 ROW
                    left: screenSize.width * 0.55,
                    top: 200,
                    child:
                      Row(
                        children: [
                          Positioned( // 이메일
                            child: Container(
                              width: 300,
                              height: 50,
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
                                          controller: emailController,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: const InputDecoration(
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
                                          style: const TextStyle(
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
                          const SizedBox(width: 10,),
                          const Positioned( // @
                            child: DefaultTextStyle(
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
                          const SizedBox(width: 10,),
                          Positioned( // 도메인
                            child: Container(
                                width: 200,
                                height: 50,
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
                          const SizedBox(width: 10,),
                          Positioned( // 인증 메일 전송
                            left: screenSize.width * 0.84,
                            top: 200,
                            child: Container(
                              width: 150,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                                    child: const DefaultTextStyle(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
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
                          ],
                        ),
                  ),
                  Positioned( // 이메일 인증 ROW
                    left: screenSize.width * 0.55,
                    top: 270,
                    child: Row(children: [
                        Positioned( // 이메일 인증
                          child: Container(
                            width: 537,
                            height: 50,
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
                                        controller: emailVerifyController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: const InputDecoration(
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
                                        style: const TextStyle(
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
                        const SizedBox(width: 10,),
                        Positioned( // 인증 확인
                          child: Container(
                            width: 150,
                            height: 50,
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
                                    _CheckVerifyEmail();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    minimumSize: const Size(100, 50),
                                  ),
                                  child: const DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                      height: 0.04,
                                      letterSpacing: -0.12,
                                    ),
                                    child: Text(
                                      ' 인증 확인 ',
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
                  Positioned( // 이름
                    left: screenSize.width * 0.55,
                    top: 340,
                    child: Container(
                      width: 537,
                      height: 50,
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
                                  autofocus: true,
                                  obscureText: false,
                                  controller: nameController,
                                  decoration: const InputDecoration(
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
                  Positioned( // 학번
                    left: screenSize.width * 0.55,
                    top: 410,
                    child: Container(
                      width: 537,
                      height: 50,
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
                                  controller: studentIdController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: const InputDecoration(
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
                  Positioned( // 비밀번호
                    left: screenSize.width * 0.55,
                    top: 480,
                    child: Container(
                      width: 537,
                      height: 50,
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
                  Positioned( // 비밀번호 확인
                    left: screenSize.width * 0.55,
                    top: 550,
                    child: Container(
                      width: 537,
                      height: 50,
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
                  Positioned( // 가입하기!
                    left: screenSize.width * 0.55,
                    top: 800,
                    child: Container(
                      width: 700,
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _passwordsMatch() 
                              ? () { _SendSignup(); }
                              : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size(100, 50),
                            ),
                            child: const DefaultTextStyle(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

