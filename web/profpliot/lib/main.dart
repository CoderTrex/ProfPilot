import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:profpliot/screen/error/error.dart';
import 'package:profpliot/screen/login/login.dart';
import 'package:profpliot/screen/mobile/homePage.dart';
import 'package:profpliot/screen/pc/homePage.dart';
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
    home = PcLogin();
    // home = PcHomePage();
    print("Platform is is PC");
  } else {
    home = PlatformErrorPage();
    print("Platform is is unknown");
  }
  runApp(MaterialApp(home: home));
}
