import 'package:profpliot/view/login/login.dart';
import 'package:profpliot/view/login/popup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageAppState createState() => _SignUpPageAppState();
}

class _SignUpPageAppState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          SignUp(),
        ]),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _textControllerName = TextEditingController();
  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();

  bool isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 50),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Stack(
                          children: [
                            // Join Us Now!
                            const Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 1000,
                                height: 60,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Join Us Now!',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // enter your name
                            Positioned(
                              left: 0,
                              top: 120,
                              child: SizedBox(
                                width: 400,
                                height: 60,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 404,
                                      height: 32,
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, bottom: 10),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFD9D9D9)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _textControllerEmail,
                                              decoration: const InputDecoration(
                                                hintText: 'Enter your name',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFFD9D9D9),
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
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
                            // enter your email address
                            Positioned(
                              left: 0,
                              top: 190,
                              child: SizedBox(
                                width: 400,
                                height: 60,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email address',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 404,
                                      height: 32,
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, bottom: 10),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFD9D9D9)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _textControllerEmail,
                                              decoration: const InputDecoration(
                                                hintText:
                                                    'Enter your email address',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFFD9D9D9),
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
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
                            // enter your password
                            Positioned(
                              left: 0,
                              top: 260,
                              child: SizedBox(
                                width: 400,
                                height: 60,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 404,
                                      height: 32,
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10, bottom: 10),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFD9D9D9)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  _textControllerPassword,
                                              decoration: const InputDecoration(
                                                hintText: 'Enter your password',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFFD9D9D9),
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
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
                            // I agree to the terms & policy
                            Positioned(
                              left: 0,
                              top: 350,
                              child: SizedBox(
                                width: 400,
                                height: 15,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          // 텍스트를 눌렀을 때 팝업 창 표시 로직 추가
                                          showPopup(context);
                                        },
                                        child: const SizedBox(
                                          width: 400,
                                          height: 20,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'I agree to the terms & policy (click to check the details)',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: GestureDetector(
                                        onTap: () {
                                          // 클릭 이벤트 처리
                                          setState(() {
                                            isAgreed = !isAgreed;
                                          });
                                        },
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            color: isAgreed
                                                ? Colors.blue
                                                : Colors
                                                    .transparent, // 클릭 여부에 따라 색상 변경
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Sign Up
                            Positioned(
                              left: 0,
                              top: 388.49,
                              child: GestureDetector(
                                onTap: saveToJson,
                                child: Container(
                                  width: 404,
                                  height: 35.02,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 3, 55, 23),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // distinguished from login
                            Positioned(
                              left: 3,
                              top: 482.60,
                              child: SizedBox(
                                width: 400,
                                height: 15.32,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 9,
                                      child: Container(
                                        width: 400,
                                        decoration: const ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 2,
                                              strokeAlign:
                                                  BorderSide.strokeAlignCenter,
                                              color: Color(0xFFF5F5F5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Don't have an account? Sign Up
                            Positioned(
                              left: 100,
                              top: 570,
                              child: SizedBox(
                                width: 250,
                                height: 25,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'have an account?  ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Sign In',
                                            style: const TextStyle(
                                              color: Color(0xFF0F3CDE),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                              decoration: TextDecoration
                                                  .underline, // 밑줄 추가
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        const LoginPage(),
                                                    transitionsBuilder:
                                                        (context,
                                                            animation,
                                                            secondaryAnimation,
                                                            child) {
                                                      const begin =
                                                          Offset(1.0, 0.0);
                                                      const end = Offset.zero;
                                                      const curve =
                                                          Curves.easeInOut;
                                                      var tween = Tween(
                                                              begin: begin,
                                                              end: end)
                                                          .chain(CurveTween(
                                                              curve: curve));
                                                      var offsetAnimation =
                                                          animation
                                                              .drive(tween);
                                                      return SlideTransition(
                                                          position:
                                                              offsetAnimation,
                                                          child: child);
                                                    },
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 900),
                                                  ),
                                                );
                                              },
                                          ),
                                        ],
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
                ],
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white, // 흰색 배경
          ),
          child: const ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              bottomLeft: Radius.circular(50.0),
            ),
            child: Image(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2021/05/06/12/39/hexagon-6233333_1280.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  void saveToJson() {
    Map<String, dynamic> data = {
      'name': _textControllerName.text,
      'email': _textControllerEmail.text,
      'password': _textControllerPassword.text,
    };

    String jsonData = jsonEncode(data);
  }
}
