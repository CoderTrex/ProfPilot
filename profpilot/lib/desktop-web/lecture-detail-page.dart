import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
              
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFF444444)),
          child: Stack(
            children: [
              Positioned( // 헤더
                left: 0,
                top: 0,
                child: Container(
                  width: screenSize.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.800000011920929),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20), // 왼쪽 여백을 만들기 위해 SizedBox를 사용합니다.
                      Text(
                        '프로프파일럿',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'AppleSDGothicNeo',
                          fontWeight: FontWeight.w400,
                          height: 0.04,
                          letterSpacing: -0.12,
                        ),
                      ),
                      Spacer(), // 중간에 공간을 만들기 위해 Spacer를 사용합니다.
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '수업',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'AppleSDGothicNeo',
                              fontWeight: FontWeight.w400,
                              height: 0.04,
                              letterSpacing: -0.12,
                            ),
                          ),
                          SizedBox(width: 50), // 각 위젯 사이의 간격 조정을 위해 SizedBox를 사용합니다.
                          Text(
                            '내 정보',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'AppleSDGothicNeo',
                              fontWeight: FontWeight.w400,
                              height: 0.04,
                              letterSpacing: -0.12,
                            ),
                          ),
                        ],
                      ),
                      Spacer(), // 프로프파일럿과 수업&내정보 사이의 공간을 만들기 위해 Spacer를 사용합니다.
                      Text(
                        '로그아웃',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'AppleSDGothicNeo',
                          fontWeight: FontWeight.w400,
                          height: 0.04,
                          letterSpacing: -0.12,
                        ),
                      ),
                      SizedBox(width: 20), // 오른쪽 여백을 만들기 위해 SizedBox를 사용합니다.
                    ],
                  ),
                ),
              ),
              Positioned(
                right: screenSize.width * 0.02,
                top: 60,
                child: Container(
                  width: 400,
                  height: 40,
                  decoration: 
                    ShapeDecoration(
                      color: Color(0x19D9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: '강의 검색',
                      hintStyle: TextStyle(
                        color: Color(0xFFD9D9D9),
                        fontSize: 20,
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.w400,
                        height: 0.04,
                        letterSpacing: -0.12,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFD9D9D9),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const Positioned( // 안녕하세요. 🐋
                left: 193,
                top: 152,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '안녕하세요.',
                        style: TextStyle(
                          color: Color(0xFF9F9F9F),
                          fontSize: 48,
                          fontFamily: 'BM HANNA_TTF',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                          letterSpacing: -0.14,
                        ),
                      ),
                      TextSpan(
                        text: '\u{1FAE0}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 237, 255, 75),
                          fontSize: 48,
                          fontFamily: 'BM HANNA_TTF',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                          letterSpacing: -0.14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned( // 오늘은 N개의 수업이 있습니다.
                left: 193,
                top: 221,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '오늘은 ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'BM HANNA_TTF',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                          letterSpacing: -0.14,
                        ),
                      ),
                      TextSpan(
                        text: 'N',
                        style: TextStyle(
                          color: Color(0xFF88C3FF),
                          fontSize: 48,
                          fontFamily: 'BM HANNA_TTF',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                          letterSpacing: -0.14,
                        ),
                      ),
                      TextSpan(
                        text: '개의 수업이 있습니다.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'BM HANNA_TTF',
                          fontWeight: FontWeight.w400,
                          height: 0.02,
                          letterSpacing: -0.14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFF444444)),
          child: SingleChildScrollView(
            controller: _pageController,
            scrollDirection: Axis.horizontal, // 수평 스크롤 설정
            child: Row(
              children: List.generate(10, (index) {
                return Container(
                  width: 500, // 적절한 너비 설정
                  height: 500, // 적절한 높이 설정
                  margin: EdgeInsets.only(left: 300, right: 100), // 적절한 마진 설정
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
                );
              } 
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}