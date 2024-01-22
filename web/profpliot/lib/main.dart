import 'package:flutter/material.dart';
import 'package:profpliot/view/error/error.dart';
import 'package:profpliot/view/login/login.dart';
import 'package:profpliot/view/mobile/homePage.dart';
import 'package:get/get.dart';

bool isMobile = GetPlatform.isMobile;
bool isDesktop = GetPlatform.isDesktop;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget home;
  if (isMobile) {
    home = MobileHomePage();
    print("Platform is is Mobile");
  } else if (isDesktop) {
    home = FigmaToCodeApp();
    print("Platform is is PC");
  } else {
    home = PlatformErrorPage();
    print("Platform is is unknown");
  }
  runApp(MaterialApp(home: home));
}
