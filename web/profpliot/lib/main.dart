import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:profpliot/model/login.dart';
import 'package:profpliot/view/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

bool isMobile = GetPlatform.isMobile;
bool isDesktop = GetPlatform.isDesktop;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBw1wpNFoRzAvLBLTf8HBMN5Y_1fzpkIiY",
      appId: "1:853383036131:web:198c5b2db4548fcff059d6",
      messagingSenderId: "853383036131",
      projectId: "prof-pilot",
    ),
  );
  runApp(const Myproject());
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
