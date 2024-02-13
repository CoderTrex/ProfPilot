import 'package:firebase_auth/firebase_auth.dart';
import 'package:profpliot/view/error/signup_error.dart';
import 'package:profpliot/view/login/login.dart';
import 'package:profpliot/view/login/popup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore_for_file: library_private_types_in_public_api
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

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
        body: ListView(children: const [
          SignUp(),
        ]),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _textControllerName = TextEditingController();
  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();

  bool isAgreed = false;
  bool isChecked = false;
  bool isExist = true;

  User? user;

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
                        padding: const EdgeInsets.only(left: 100),
                        width: MediaQuery.of(context).size.width * 0.5,
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
                                            controller: _textControllerName,
                                            cursorWidth: 10,
                                            cursorHeight: 1,
                                            cursorColor: Colors.black,
                                            decoration: const InputDecoration(
                                              hintText: 'Enter your name',
                                              hintStyle: TextStyle(
                                                color: Color(0xFFD9D9D9),
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 1,
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
                                          )),
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
                                width: 1000,
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
                                    Row(
                                      children: [
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
                                                  controller:
                                                      _textControllerEmail,
                                                  cursorWidth: 10,
                                                  cursorHeight: 1,
                                                  cursorColor: Colors.black,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        'Enter your email address',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFFD9D9D9),
                                                      fontSize: 10,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                        // const SizedBox(width: 10),
                                        // Positioned(
                                        //     child: GestureDetector(
                                        //   onTap: () async {
                                        //     // 클릭 이벤트 처리
                                        //     setState(
                                        //       () async {
                                        //         // if email is exist, return false
                                        //         isExist =
                                        //             await checkEmailVerify(
                                        //                 _textControllerEmail
                                        //                     .text);
                                        //         if (!isExist)
                                        //           isChecked = !isChecked;
                                        //         else {
                                        //           showDialog(
                                        //             context: context,
                                        //             builder:
                                        //                 (BuildContext context) {
                                        //               return AlertDialog(
                                        //                 title:
                                        //                     const Text("Error"),
                                        //                 content: const Text(
                                        //                     "Email is not available. Please enter another email address."),
                                        //                 actions: [
                                        //                   TextButton(
                                        //                     onPressed: () {
                                        //                       Navigator.pop(
                                        //                           context);
                                        //                     },
                                        //                     child: const Text(
                                        //                         "OK"),
                                        //                   ),
                                        //                 ],
                                        //               );
                                        //             },
                                        //           );
                                        //         }
                                        //       },
                                        //     );
                                        //   },
                                        //   child: Container(
                                        //     width: 10,
                                        //     height: 10,
                                        //     decoration: ShapeDecoration(
                                        //       shape: RoundedRectangleBorder(
                                        //         side:
                                        //             const BorderSide(width: 1),
                                        //         borderRadius:
                                        //             BorderRadius.circular(2),
                                        //       ),
                                        //       color: isChecked
                                        //           ? Colors.blue
                                        //           : Colors
                                        //               .transparent, // 클릭 여부에 따라 색상 변경
                                        //     ),
                                        //   ),
                                        // )),
                                        // const SizedBox(width: 10),
                                        // const Text(
                                        //   'Check email available',
                                        //   style: TextStyle(
                                        //     color: Colors.black,
                                        //     fontSize: 10,
                                        //     fontFamily: 'Poppins',
                                        //     fontWeight: FontWeight.w500,
                                        //     height: 0,
                                        //   ),
                                        // ),
                                      ],
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
                                              cursorWidth: 10,
                                              cursorHeight: 1,
                                              cursorColor: Colors.black,
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
                                onTap: () async {
                                  try {
                                    if (_textControllerName.text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const ErrorDialog(
                                              errorMessage:
                                                  "Name is empty. Please enter your name.");
                                        },
                                      );
                                      return;
                                    } else if (_textControllerEmail
                                        .text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const ErrorDialog(
                                              errorMessage:
                                                  "Email is empty. Please enter your email address.");
                                        },
                                      );
                                      return;
                                    } else if (_textControllerPassword
                                        .text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const ErrorDialog(
                                              errorMessage:
                                                  "Password is empty. Please enter your password.");
                                        },
                                      );
                                      return;
                                    } else if (!isAgreed) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const ErrorDialog(
                                              errorMessage:
                                                  "Please agree to the terms & policy.");
                                        },
                                      );
                                      return;
                                    }

                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                      email: _textControllerEmail.text.trim(),
                                      password:
                                          _textControllerPassword.text.trim(),
                                    );
                                    user = userCredential.user;
                                    if (user != null && !user!.emailVerified) {
                                      await user!.sendEmailVerification();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    }
                                    // Account creation successful
                                  } catch (e) {
                                    String errorMessage =
                                        "Error creating account: $e";
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ErrorDialog(
                                            errorMessage: errorMessage);
                                      },
                                    );
                                  }
                                },
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
                            // have an account? Sign In
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
                                                        const Duration(
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
        // image next to the sign up page
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
}
