import 'package:flutter/material.dart';
import 'package:profpilot/front-end/find-password.dart';
import 'package:profpilot/main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _passwordsMatch() {
  return passwordController1.text == passwordController2.text;
  }

  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  String selectedDomain = '도메인을 선택하세요'; // 기본값 설정


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return  Scaffold(
    body: Column(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFF444444)),
          child: Stack(
            children: [
              const Positioned( // 환영합니다. 🦕
                left: 76,
                top: 428,
                child:
                DefaultTextStyle (
                  style: TextStyle(
                    color: Colors.white,
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
              const Positioned( // 새로운 친구는 언제나 환영이죠!
                left: 76,
                top: 495,
                child: 
                DefaultTextStyle (
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
              const Positioned( // 회원가입
                left: 1309,
                top: 75,
                child: SizedBox(
                  width: 100,
                  height: 52,
                  child: 
                  DefaultTextStyle (
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'BMHANNAPro',
                      fontWeight: FontWeight.w400,
                      height: 0.13,
                      letterSpacing: -0.14,
                    ),
                    child: Text(
                      '회원가입',
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
                      DefaultTextStyle (
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
                  padding: const EdgeInsets.symmetric(horizontal: 61, vertical: 14),
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
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shadowColor: Colors.transparent,
                        
                      ),
                      child: const DefaultTextStyle (
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
                          MaterialPageRoute(builder: (context) => FindPasswordPage()),
                        );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shadowColor: Colors.transparent,
                        ),
                        child: const DefaultTextStyle (
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
              Positioned( // 이메일
                left: screenSize.width / 2 - 600 / 2,
                top: 199,
                child: Container(
                  width: 300,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '이메일',
                            hintStyle: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            )
                          ),
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 25,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                          )
                        )
                      )
                    ],
                  ),
                ),
              ),
              Positioned( // @
                left: screenSize.width / 2 + 18,
                top: 250, 
                child: const DefaultTextStyle (
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'BMHANNAPro',
                    fontWeight: FontWeight.w400,
                    height: 0.06,
                    letterSpacing: -0.14,
                  ),
                  child: Text(
                    '@',
                  ),
                ),
              ),           
              Positioned( // 도메인
                left: screenSize.width / 2 + 50,
                top: 199,
                child: Container(
                  width: 300,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical:20),
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
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            ),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                  )
                )
              ),
              Positioned( // 이름
                left: screenSize.width / 2 - 600 / 2,
                top: 303,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '이름',
                            hintStyle: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            )
                          ),
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 25,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                          )
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // 비밀번호
                left: screenSize.width / 2 - 600 / 2,
                top: 407,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            )
                          ),
                        style: const TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 25,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                          )
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // 비밀번호 확인
                left: screenSize.width / 2 - 600 / 2,
                top: 511,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            color: _passwordsMatch() ? Colors.green : Colors.red,
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
              Positioned( // 전공
                left: screenSize.width / 2 - 600 / 2,
                top: 615,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '전공',
                            hintStyle: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            )
                          ),
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 25,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                          )
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // 소속학교
                left: screenSize.width / 2 - 600 / 2,
                top: 719,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '소속학교',
                            hintStyle: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            )
                          ),
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 25,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                          )
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // 학번
                left: screenSize.width / 2 - 600 / 2,
                top: 823,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '학번',
                            hintStyle: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 25,
                              fontFamily: 'BMHANNAPro',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                              letterSpacing: -0.14,
                            )
                          ),
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 25,
                          fontFamily: 'BMHANNAPro',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                          letterSpacing: -0.14,
                          )
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // 가입하기!
                left: screenSize.width / 2 - 600 / 2,
                top: 976,
                child: Container(
                  width: 650,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 48),
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
    );
  }
}