import 'package:flutter/material.dart';
import 'package:profpliot/screen/error/error.dart';
import 'package:profpliot/screen/mobile/homePage.dart';
import 'package:profpliot/screen/pc/homePage.dart';
import 'package:get/get.dart';

bool isMobile = GetPlatform.isMobile;
bool isDesktop = GetPlatform.isDesktop;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget home;
  if (isMobile) {
    home = MobileHomePage();
    print("Platform is is Mobile");
  } else if (isDesktop) {
    home = PcHomePage();
    print("Platform is is PC");
  } else {
    home = PlatformErrorPage();
    print("Platform is is unknown");
  }
  runApp(MaterialApp(home: home));
}
