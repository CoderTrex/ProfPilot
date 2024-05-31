
import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profpilot/DTO/myedit-dto.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-edit.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-password.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';

class PersonalEmailPage extends StatefulWidget {
  const PersonalEmailPage({super.key});

  @override
  State<PersonalEmailPage> createState() => _PersonalEmailPageState();
}

class _PersonalEmailPageState extends State<PersonalEmailPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailCheckController = TextEditingController();
  String selectedDomain = '도메인을 선택하세요';
  
  Future<bool> _initPageController() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      );
    }

    final Dio dio = Dio();
    
    try{
      final Response response = await dio.get(
        'http://localhost:8080/member/check',
        options: Options(
          headers: {
            'access' : accessToken,
          }
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        window.alert('페이지를 불러오는데 실패했습니다.');
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => LoginPage()
          )
        );
        return false;
      }
    } catch (e) {
      window.alert('페이지를 불러오는데 실패했습니다.');
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      );
      return false;
    }
  }

  Future<bool> _SendVerifyCode() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      );
    }

    final Dio dio = Dio();
    
    String fullEmail = '${emailController.text}@$selectedDomain';

    try{
      final Response response = await dio.post(
        'http://localhost:8080/member/email/verify',
        options: Options(
          headers: {
            'access' : accessToken,
          },
          extra: {
            'withCredentials': true,
          },
        ),
        data: {
          'email': fullEmail,
        },
      );
      if (response.statusCode == 200) {
        if (response.data == 'success') {
          // ignore: use_build_context_synchronously
          showAboutDialog(context: context, applicationName: '성공', children: [const Text('성공적으로 이메일을 보냈습니다.')] );
        } else if (response.data == 'already') {
          // ignore: use_build_context_synchronously
          showAboutDialog(context: context, applicationName: '이미 인증됨', children: [const Text('이미 인증된 이메일입니다.')] );
        } else if (response.data == 'wait') {
          // ignore: use_build_context_synchronously
          showAboutDialog(context: context, applicationName: '실패', children: [const Text('5분 이내로 이미 전송된 이메일이 있습니다.')] );
        } else {
          // ignore: use_build_context_synchronously
          showAboutDialog(context: context, applicationName: '실패', children: [const Text('이메일을 보내는데 실패했습니다.')] );
        }
        setState(() {});
        return true;
    } else {
        // ignore: use_build_context_synchronously
      showAboutDialog(context: context, applicationName: '실패', children: [const Text('이메일을 보내는데 실패했습니다.')] );
      setState(() {
      });
      return false;
    }
    } 
    catch (e) {
      window.alert('이메일을 보내는데 실패했습니다.');
      return false;
    }
  } 

  Future<void> _CheckVerifyCode() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      );
    }

    final Dio dio = Dio();

  // get 요청은 json으로 안넘어갈 수도 있다.
  // query param string으로 넘어간다.

    String fullEmail = '${emailController.text}@$selectedDomain';
    try{
      final Response response = await dio.post(
        'http://localhost:8080/member/email/verify/check',
        options: Options(
          headers: {
            'access' : accessToken,
          },
          extra: {
          'withCredentials': true,
        },
        ),
        data: {
          'email': fullEmail,
          'verifyCode': emailCheckController.text,
        }
      );
      if (response.statusCode == 200) {
        window.alert('이메일 인증에 성공했습니다.');
      } else {
        window.alert('이메일 인증에 실패했습니다.');
      }
    } catch (e) {
      print(e);
      window.alert('이메일 인증에 실패했습니다.');
    }
  }

  Future<void> _ChangeEmail() async {
    final String? accessToken = window.localStorage['token'];

    if (accessToken == null) {
      window.alert('로그인이 필요합니다.');
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      );
    }

    final Dio dio = Dio();

    String fullEmail = '${emailController.text}@$selectedDomain';
    try{
      final Response response = await dio.put(
        'http://localhost:8080/member/email/change',
        options: Options(
          headers: {
            'access' : accessToken,
          }
        ),
        data: {
          'email': fullEmail,
          'verifyCode': emailCheckController.text,
        }
      );
      if (response.statusCode == 200) {

        window.alert('이메일 변경에 성공했습니다.');
      } else {
        window.alert('이메일 변경에 실패했습니다.');
      }
    } catch (e) {
      print(e);
      window.alert('이메일 변경에 실패했습니다.');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _initPageController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: 
                  AssetImage('assets/images/apple3.png'), 
                  fit: BoxFit.cover
                ),
                color: Colors.white,
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
                                      builder: (context) => const PersonalMainPage()
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
                  const Row(children: [ // 흠... 학교 이메일이 변경되는 일이 있을까요?
                    SizedBox(width: 200),
                    Positioned(
                      child: Text(
                        '흠... 학교 이메일이 변경되는 일이 있을까요?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                          letterSpacing: -0.14,
                        ),
                      ),
                    ),
                  ],),
                  const SizedBox(height: 20),
                  const Row(children: [ // 누가 쓸진 모르지만, 만들어 둘게요 :)
                    SizedBox(width: 200),
                    Positioned(
                      child: Text(
                        '누가 쓸진 모르지만, 만들어 둘게요 :)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 57, 65),
                          fontSize: 15,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                        ),
                      ),
                    ),
                  ],),
                  const SizedBox(height: 30),
                  Row(children: [
                    SizedBox(width: screenSize.width * 0.5 - 200),
                    Column(
                      children: [
                        Row( children: [
                          Container( // 이메일 입력
                            width: 200,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: "바꿀 이메일을 입력해주세요",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'BMHANNAPro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          ),
                          const SizedBox(width: 10,),
                          const Positioned( // @
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
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
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16),
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
                              items: ['도메인을 선택하세요', 'khu.ac.kr', 'gmail.com', 'naver.com']
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
                            ))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            if (await _SendVerifyCode()) {
                              setState(() {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.1),
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(30, 30),
                          ),
                          child: const DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.14,
                            ),
                            child: Text(
                              '인증 코드 보내기',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container( // 인증 코드 입력
                          width: 400,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: TextField(
                                controller: emailCheckController,
                                decoration: const InputDecoration(
                                  hintText: "이메일 인증 코드를 입력해주세요",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontSize: 10,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                ),
                                
                              ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await _CheckVerifyCode();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.1),
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(30, 30),
                          ),
                          child: const DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.14,
                            ),
                            child: Text(
                              '인증 코드 확인',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await _ChangeEmail();
                          },
                          style: ElevatedButton.styleFrom(
                            
                            backgroundColor: Colors.black.withOpacity(0.5),
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(30, 30),
                          ),
                          child: const DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.14,
                            ),
                            child: Text(
                              '이메일 변경',
                            ),
                          ),
                        ),
                      ],
                  ),
                  ],),
                  const SizedBox(height: 100),
                  Row(children: [
                    SizedBox(width: screenSize.width * 0.8 - 200),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => PersonalEditPage()
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
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => PersonalPasswordPage()
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
                          '비밀번호 변경',
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    ],), 
                ],
              ),
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),

    );
  }
}
