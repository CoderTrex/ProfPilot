
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profpilot/DTO/myedit-dto.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/my-email.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/my-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/my-update.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/my-password.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';




class PersonalEditPage extends StatefulWidget {
  const PersonalEditPage({super.key});

  @override
  State<PersonalEditPage> createState() => _PersonalEditPageState();
}

class _PersonalEditPageState extends State<PersonalEditPage> {
  
  
  Future<MyEditDTO> _initPageController() async {
    final String? accessToken = window.localStorage['token'];
    final MyEditDTO myEditDTO;

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
        'http://localhost:8080/member/my-info',
        options: Options(
          headers: {
            'access' : accessToken,
          }
        ),
      );
      MyEditDTO myEditDTO = MyEditDTO.fromResponse(response);
      return myEditDTO;
    } catch (e) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const LoginPage()
        )
      );
    }
    return MyEditDTO.empty();
  }

  Future<bool> _checkPassword(String password) async {
    final String? accessToken = window.localStorage['token'];
    final MyEditDTO myEditDTO;
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
      final response = await dio.post(
        'http://localhost:8080/member/check-password',
        options: Options(
          headers: {
            'access' : accessToken,
          }
        ),
        data: {
          'password' : password,
          'newPassword' : '',
        }
      );
      return response.data;
    } catch (e) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const LoginPage()
        )
      );
    }
    return false;
  }

  Future<void> _GotoPasswordChange() async {
    final TextEditingController passwordController = TextEditingController();
    bool isPassword = false;

    // 비밀번호 확인 모달
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('비밀번호를 입력해주세요'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: '비밀번호',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                bool passwordCheck = await _checkPassword(passwordController.text);
                if (passwordCheck) {
                  isPassword = true;
                  Navigator.pop(context);  // 다이얼로그 닫기
                } else {
                  Navigator.pop(context);  // 다이얼로그 닫기
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('비밀번호가 일치하지 않습니다.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );

    // 비밀번호가 맞는 경우 비밀번호 변경 페이지로 이동
    if (isPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalPasswordPage(),
        ),
      );
    }
  }

  Future<void> _GotoEmailChange() async {
    final TextEditingController passwordController = TextEditingController();
    bool isPassword = false;

    // 비밀번호 확인 모달
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('비밀번호를 입력해주세요'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: '비밀번호',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                bool passwordCheck = await _checkPassword(passwordController.text);
                if (passwordCheck) {
                  isPassword = true;
                  Navigator.pop(context);  // 다이얼로그 닫기
                } else {
                  Navigator.pop(context);  // 다이얼로그 닫기
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('비밀번호가 일치하지 않습니다.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );

    // 비밀번호가 맞는 경우 비밀번호 변경 페이지로 이동
    if (isPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalEmailPage(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    _initPageController();
    return Scaffold(

      body: FutureBuilder<MyEditDTO>(
        future: _initPageController(),
        builder: (BuildContext context, AsyncSnapshot<MyEditDTO> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            MyEditDTO myEditDTO = snapshot.data!;
            return  Container(
            width: screenSize.width,
            height: screenSize.height,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/apple3.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Positioned( // 헤더
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
                const SizedBox(height: 50),
                const Row(children: [ // 개인정보는 소중하게 다뤄주세요 :)
                  SizedBox(width: 200),
                  Positioned(
                    child: Text(
                      '개인정보는 소중하게 다뤄주세요 :|',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'BMHANNAPro',
                        fontWeight: FontWeight.w400,
                        height: 0.02,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ),
                ],),
                const SizedBox(height: 20),
                const Row(children: [ // 채우고 싶지 않는 정보는 비워도 됩니다. :)
                  SizedBox(width: 200),
                  Positioned(
                    child: Text(
                      '꼭 안전하게 보관해줘요 :)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 57, 65),
                        fontSize: 10,
                        fontFamily: 'BMHANNAPro',
                        fontWeight: FontWeight.w400,
                        height: 0.02,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ),
                ],),
                const SizedBox(height: 50),
                Row(children: [
                  SizedBox(width: screenSize.width * 0.5 - 400),
                  Positioned(
                    child: SizedBox(
                      width: 800,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container( // 이메일, 비밀번호
                            height: 20,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded( // 이메일
                                  child: Container(
                                    // padding: const EdgeInsets.symmetric(vertical: 17),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '이메일',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            // height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.email,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded( // 비밀번호
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '비밀번호',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "안전하게 보관해주세요 :)",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container( // 학번, 역할
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded( // 학번
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '학번',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.studentId,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded( // 역할
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '역할',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.role,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container( // 이름, 활동 여부
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded( // 이름
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '이름',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded( // 활동 여부
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '활동 여부',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.status,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container( // 대학, 가입일
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded( // 대학
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '대학',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.university,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded( // 가입일
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '가입일',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.createAt,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container( // 전공
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded( // 전공
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '전공',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.major,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0.04,
                                            letterSpacing: -0.12,
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
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.2),
                ],),
                const SizedBox(height: 70),
                Row(children: [
                  SizedBox(width: screenSize.width * 0.8 - 400),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            PersonalUpdatePage()
                        )
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
                        '개인정보 변경',
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () 
                    {
                      _GotoPasswordChange();
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
                        '비밀번호 변경',
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () {
                      _GotoEmailChange();
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
                        '이메일 변경'
                      ),
                    ),
                  ),
                ],),
              ],
            ), 
              
            
            );
          } else {
            return const Center(child: Text('Error'));
          }  
        }
      )    
    );
  }
}