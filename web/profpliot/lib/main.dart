import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profpliot/model/login.dart';
import 'package:profpliot/view/error/error.dart';
import 'package:profpliot/view/login/login.dart';
import 'package:profpliot/view/mobile/homePage.dart';

bool isMobile = GetPlatform.isMobile;
bool isDesktop = GetPlatform.isDesktop;

// https://monsh.tistory.com/89

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget home;
  if (isMobile) {
    home = MobileHomePage();
    // print("Platform is Mobile");
  } else if (isDesktop) {
    home = const LoginPage();
    // print("Platform is PC");
  } else {
    home = PlatformErrorPage();
    // print("Platform is unknown");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Login()),
      ],
      child: MaterialApp(
        home: home,
      ),
    ),
  );
}
