import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-detail.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/my-update.dart';
import 'package:profpilot/view/desktop-web/before-auth/Login-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/main/main-page.dart';
import 'package:profpilot/view/desktop-web/after-auth/personal/my-page.dart';
import 'package:profpilot/view/mobile-web/M-login-page.dart';

class Breakpoint {
  final double start;
  final double end;
  final String name;

  const Breakpoint(
      {required this.start, required this.end, required this.name});
}

const List<Breakpoint> breakpoints = [
  Breakpoint(start: 0, end: 450, name: 'MOBILE'),
  Breakpoint(start: 451, end: 800, name: 'TABLET'),
  Breakpoint(start: 801, end: 1920, name: 'DESKTOP'),
  Breakpoint(start: 1921, end: double.infinity, name: '4K'),
];

String getBreakpointName(double width) {
  for (Breakpoint breakpoint in breakpoints) {
    if (width >= breakpoint.start && width <= breakpoint.end) {
      return breakpoint.name;
    }
  }
  return 'Unknown';
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        String breakpointName = getBreakpointName(screenWidth);

        Widget home;
        switch (breakpointName) {
          case 'MOBILE':
            home = const LoginPageMobile();
            break;
          default:
            home = const LoginPage(); // 기본값으로 데스크탑 페이지를 사용
        }
        home = PersonalUpdatePage();
        return MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 69, 131, 197),
          ),
          home: home,
          scrollBehavior: MyCustomScrollBehavior(),
        );
      },
    );
  }
}
