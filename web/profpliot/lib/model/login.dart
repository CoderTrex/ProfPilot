import 'package:flutter/material.dart';

class Login with ChangeNotifier {
  bool _isLogin = false;
  String? email;
  bool get isLogin => _isLogin;

  Login() {
    _isLogin = false;
    email;
  }

  String getLogin_email() {
    return email!;
  }

  void setLogin_email(String? value) {
    email = value;
    notifyListeners();
  }

  void setLogin_status(bool value) {
    _isLogin = value;
    notifyListeners();
  }
}
