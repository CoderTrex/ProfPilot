import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:profpliot/model/login.dart';
import 'package:profpliot/view/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'package:profpliot/view/error/error.dart';

bool isMobile = GetPlatform.isMobile;
bool isDesktop = GetPlatform.isDesktop;
// apiKey: "AIzaSyBw1wpNFoRzAvLBLTf8HBMN5Y_1fzpkIiY",
// authDomain: "prof-pilot.firebaseapp.com",
// projectId: "prof-pilot",
// storageBucket: "prof-pilot.appspot.com",
// messagingSenderId: "853383036131",
// appId: "1:853383036131:web:198c5b2db4548fcff059d6",
// measurementId: "G-V8BHSMR44Q");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBw1wpNFoRzAvLBLTf8HBMN5Y_1fzpkIiY",
        appId: '1:853383036131:web:198c5b2db4548fcff059d6',
        messagingSenderId: "853383036131",
        projectId: "prof-pilot"),
  );
  // runApp(home);
  runApp(Myproject());
}

class Myproject extends StatelessWidget {
  const Myproject({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Login()),
      ],
      child: const MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
    // Widget home;
    // if (isMobile) {
    //   home = PlatformErrorPage();
    //   // home = MobileHomePage();
    //   // print("Platform is Mobile");
    // } else if (isDesktop) {
    //   home = const LoginPage();
    //   // print("Platform is PC");
    // } else {
    //   home = PlatformErrorPage();
    //   // print("Platform is unknown");
    // }
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => Login()),
  //     ],
  //     child: MaterialApp(
  //       home: home,
  //     ),
  //   );
  //   // return Container();
  // }
