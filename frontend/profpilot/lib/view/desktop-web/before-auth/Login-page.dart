import 'dart:html';
import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/before-auth/FindPassword-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';
import 'package:profpilot/view/desktop-web/before-auth/signup-page.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final Storage _storage = window.localStorage;
    final dio = Dio();


    if (email.isEmpty || password.isEmpty || email == '이메일을 입력해주세요.' || password == '비밀번호를 입력해주세요.') 
    {
      showAboutDialog(context: context, children: const [
        Text('이메일과 비밀번호를 입력해주세요.'),
      ]);
      return;
    }

    final response = await dio.post(
      'http://localhost:8080/login',
      data: {
        'username': email,
        'password': password,
      },
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.json,
        extra: {
          'withCredentials': true,
        },
      ),
    );
    
    if (response.statusCode != 200) {
      showAboutDialog(
        // ignore: use_build_context_synchronously
        context: context,
        children: const [
          Text('이메일 또는 비밀번호가 틀렸습니다.'),
        ],
      );
      return;
    } else {
      showAboutDialog(
        // ignore: use_build_context_synchronously
        context: context,
        children: const [
          Text('로그인 성공!'),
        ],
      );

      final String token = response.data['token'];
      _storage['token'] = token;

      // MainPage로 이동
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = 'silvercastle@khu.ac.kr';
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
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Row(
                  children: [
                  SizedBox(width: 100,),
                    Positioned(
                      // 안녕하세요.👋
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Color.fromARGB(255, 92, 145, 175),
                          fontSize: 15,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                          letterSpacing: -0.14,
                        ),
                        child: Text('안녕하세요. \u{1F44B}'),
                      ),
                    ),
                ]),
                const SizedBox(height: 20),
                const Row(
                  children: [
                  SizedBox(width: 100,),
                  Positioned(
                    // 프로프파일럿에 오신 걸 환영합니다.
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Color.fromARGB(255, 216, 216, 216),
                        fontSize: 15,
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
                ],),
                const SizedBox(height: 40),
                const Positioned(
                  child: DefaultTextStyle(
                      style: TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontSize: 10,
                        fontFamily: 'BMHANNAPro',
                        fontWeight: FontWeight.w400,
                        height: 0.13,
                        letterSpacing: -0.14,
                      ),
                      child: Text('프로프파일럿에 로그인'),
                    ),
                ),
                const SizedBox(height: 20),
                Positioned(
                  // 이메일
                  child: Container(
                    width: 300,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
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
                                fontSize: 10,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.14,
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 10,
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
                const SizedBox(height: 10),
                Positioned(
                  // 비밀번호
                  child: Container(
                    width: 300,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
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
                                fontSize: 10,
                                fontFamily: 'BMHANNAPro',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.14,
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 10,
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
                const SizedBox(height: 30),
                Positioned(
                  child: Container(
                    width: 150,
                    height: 30,
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
                    child: 
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
                            fontSize: 10,
                            fontFamily: 'BMHANNAPro',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                            letterSpacing: -0.14,
                          ),
                        ),
                      ),
                  ),
                ),
                const SizedBox(height: 30),
                Positioned(
                  // 회원 가입, 비밀번호를 잊으셨나요?
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              fontSize: 10,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.04,
                              letterSpacing: -0.12,
                            ),
                            child: Text('회원가입'),
                          ),
                        ),
                        const SizedBox(width: 100),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FindPasswordPage()),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
