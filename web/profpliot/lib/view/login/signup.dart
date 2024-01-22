import 'package:flutter/material.dart';
import 'dart:convert';

class FigmaToCodeApp extends StatefulWidget {
  const FigmaToCodeApp({Key? key}) : super(key: key);

  @override
  _FigmaToCodeAppState createState() => _FigmaToCodeAppState();
}

class _FigmaToCodeAppState extends State<FigmaToCodeApp> {
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

Widget _highlightTitles(String content) {
  List<String> lines = content.split('\n');
  List<Widget> widgets = [];

  for (String line in lines) {
    if (line.trim().startsWith(RegExp(r'^\d+-\d+\.'))) {
      // Highlight titles (e.g., 1-1., 2-1., 3-1.)
      widgets.add(
        Text(
          line,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      widgets.add(Text(line));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}

Widget _buildPolicySection(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 8),
      _highlightTitles(content),
      const SizedBox(height: 16),
    ],
  );
}

void _showPopup(BuildContext context) {
  String termOfServiceTitle = '1. Terms of Service';
  String termsOfService = '''
    1.1. Use of services
      1.1.1 By using the Service, you must comply with all applicable laws and regulations.
      1.2. Any illegal activity through the service is prohibited, and actions that may cause harm to other users are also strictly prohibited.

    1.2. Account security
      1.2.1 Users must keep their account information safe.
      1.2.2 Accessing another user's account or providing account information to a third party is prohibited, and the account holder is responsible for the consequences.

    1.3. Service changes and interruptions
      1.3.1 The Company reserves the right to change or discontinue any or all of the Services without prior notice.
      1.3.2 The Company is not responsible for any losses suffered by users due to changes or interruptions in the service.
  ''';

  String privacyPolicyTitle = '2. Privacy Policy';
  String privacyPolicy = '''
    2. Privacy Policy
      2.1. Information collected
        2.1.1 This service may collect essential information such as name and email when registering as a member.
        2.1.2 In addition, data collected while using the service is described in detail in the privacy policy.

      2.2. Use of information
        2.2.1 The collected information is mainly used to provide, maintain, and improve services, and to develop new services.
        2.2.2 Personal information will not be provided to other companies or organizations without the user's consent.

      2.3. Security measures
        2.3.1 Collected information is safely protected through appropriate security measures.
        2.3.2 User information will be safely disposed of even when the service is terminated.
  ''';

  String cookieUsePolicyTitle = '3. Cookie Use Policy';
  String cookieUsePolicy = '''
    3. Cookie Use Policy
      3.1. Use of cookies
        3.1.1 This service uses cookies to improve user experience and provide services.
        3.1.2 Cookies help you set up and maintain certain features.

      3.2. Refusal of cookies
        3.2.1 You may not consent to the use of cookies. However, some features may be limited in this case.
        3.2.2 More information about rejecting cookies can be found in our Cookie Use Policy.
  ''';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Terms and Policies'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPolicySection(termOfServiceTitle, termsOfService),
              _buildPolicySection(privacyPolicyTitle, privacyPolicy),
              _buildPolicySection(cookieUsePolicyTitle, cookieUsePolicy),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
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
              width: MediaQuery.of(context).size.width * 0.5,
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
                            // Enter your name
                            Positioned(
                              left: 0,
                              top: 110.53,
                              child: SizedBox(
                                width: 404,
                                height: 58,
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
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _textControllerName,
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
                              top: 188.23,
                              child: SizedBox(
                                width: 404,
                                height: 58,
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
                              top: 265.92,
                              child: SizedBox(
                                width: 404,
                                height: 58,
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
                            // I agree to the terms & policy
                            Positioned(
                              left: -0,
                              top: 343.62,
                              child: SizedBox(
                                width: 400,
                                height: 15.32,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          // 텍스트를 눌렀을 때 팝업 창 표시 로직 추가
                                          _showPopup(context);
                                        },
                                        child: const SizedBox(
                                          width: 400,
                                          height: 15.32,
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
                                      left: 0,
                                      top: 2.19,
                                      child: GestureDetector(
                                        onTap: () {
                                          // 클릭 이벤트 처리
                                          setState(() {
                                            isAgreed = !isAgreed;
                                          });
                                        },
                                        child: Container(
                                          width: 9,
                                          height: 9.85,
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
                            const Positioned(
                              left: 113,
                              top: 570,
                              child: SizedBox(
                                width: 183,
                                height: 22.98,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Have an account?  ',
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
                                            style: TextStyle(
                                              color: Color(0xFF0F3CDE),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 388.49,
                              child: GestureDetector(
                                onTap: () {
                                  print('Signup');
                                  saveToJson();
                                },
                                child: Container(
                                  width: 404,
                                  height: 35.02,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFEDF2F7)),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: SizedBox(
                                          height: 32,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 404,
                                                height: 32,
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    bottom: 10),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color:
                                                      const Color(0xFF3A5B22),
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 1,
                                                        color:
                                                            Color(0xFF3A5B22)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 185,
                                        top: 6,
                                        child: Text(
                                          'Signup',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
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
                ],
              ),
            ),
          ],
        ),
        Image(
          image: const NetworkImage(
              "https://cdn.pixabay.com/photo/2021/05/06/12/39/hexagon-6233333_1280.jpg"),
          // image: AssetImage('assets\\image\\login_main1.jpg'),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
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

    print('JSON Data: $jsonData');
  }
}
