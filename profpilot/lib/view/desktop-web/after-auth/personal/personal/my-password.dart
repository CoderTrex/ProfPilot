
import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profpilot/DTO/myedit-dto.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-edit.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-email.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/personal/my-page.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';

class PersonalPasswordPage extends StatefulWidget {
  const PersonalPasswordPage({super.key});

  @override
  State<PersonalPasswordPage> createState() => _PersonalPasswordPageState();
}

class _PersonalPasswordPageState extends State<PersonalPasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  bool _passwordsMatch() {
    return passwordController.text == passwordCheckController.text;
  }

  Future<void> _SendChangedPassword() async {
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
      final Response response = await dio.put(
        'http://localhost:8080/member/change-password',
        options: Options(
          headers: {
            'access' : accessToken,
          }
        ),
        data: {
          'password': oldPasswordController.text,
          'newPassword': passwordCheckController.text,
        }
      );
      if (response.statusCode == 200) {
        window.alert('비밀번호가 변경되었습니다.');
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => PersonalEditPage()
          )
        );
      } else {
        print("error");
        print(response.statusCode);
        window.alert('비밀번호 변경에 실패했습니다.');
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => LoginPage()
          )
        );
      }
    } catch (e) {
      print(e);
      window.alert('비밀번호 변경에 실패했습니다.');
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage()
        )
      );
    }
  }
  

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
                  const Row(children: [ // 비밀번호 변경
                    SizedBox(width: 200),
                    Positioned(
                      child: Text(
                        '비밀 번호는 3개월마다 변경해주세요!',
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
                  const Row(children: [ // 비밀번호 변경
                    SizedBox(width: 200),
                    Positioned(
                      child: Text(
                        '솔직히 털어갈게 없긴 하지만...',
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
                  const SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: screenSize.width * 0.5 - 200),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          width: 400,
                          height: 30,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: TextField(
                                controller: oldPasswordController,
                                decoration: const InputDecoration(
                                  hintText: "기존 비밀번호를 입력해주세요",
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
                        const SizedBox(height: 20),
                        Container(
                          width: 400,
                          height: 30,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  hintText: "비밀번호를 입력해주세요",
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
                        const SizedBox(height: 20),
                        Container(
                          width: 400,
                          height: 30,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: TextField(
                                controller: passwordCheckController,
                                decoration: const InputDecoration(
                                  hintText: "비밀번호를 다시 입력해주세요",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'BMHANNAPro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                style: TextStyle(
                                  color: _passwordsMatch() ? Colors.green : Colors.red, 
                                  fontSize: 10,
                                  fontFamily: 'BMHANNAPro',
                                  fontWeight: FontWeight.w400,
                                ),
                                onChanged: (_) {
                                  //setState(() {});하지 말고 TextField 위젯의 style의 color를 변경해주면 됨
                                  _passwordsMatch();
                                },
                              ),
                        ),
                      ],
                  ),
                  ],),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _passwordsMatch() 
                      ? () { _SendChangedPassword(); }
                      : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(100, 50),
                    ),
                    child: const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'BMHANNAPro',
                      fontWeight: FontWeight.w400,
                      height: 0.06,
                      letterSpacing: -0.14,
                    ),
                    child: Text(
                      '비밀번호 변경',
                    ),
                  ),
                  ),
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
                            builder: (context) => PersonalEmailPage()
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
                          '이메일 변경',
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
        },
      ),

    );
  }
}
