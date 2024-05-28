import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getToken() async {
  final String? token = window.localStorage['token'];
  return token;
}

Future<void> setToken(String token) async {
  window.localStorage['token'] = token;
}

Future<void> removeToken() async {
  window.localStorage.remove('token');
}

Future<bool> _renewalToken() async {
  final Storage _storage = window.localStorage;
  final String? email = _storage['email'];
  final String? password = _storage['password'];

  if (email == null || password == null) {
    return false;
  }
  final response = await http.post(
    Uri.parse('http://localhost:8080/login'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'username': email,
      'password': password,
    },
  );

  if (response.statusCode != 200) {
    return false;
  } else {
    final Map<String, dynamic> body = jsonDecode(response.body);
    final String token = body['token'];
    _storage['token'] = token; 
    _storage['email'] = email;
    _storage['password'] = password;
  }
  return true;
}


String? getCookie(String name) {
  String? cookies = document.cookie;
  if (cookies != null && cookies.isNotEmpty) {
    List<String> cookieList = cookies.split('; ');

    for (String cookie in cookieList) {
      if (cookie.startsWith(name)) {
        return cookie.substring(name.length + 1); // +1 to account for '='
      }
    }
  }

  return null;
}