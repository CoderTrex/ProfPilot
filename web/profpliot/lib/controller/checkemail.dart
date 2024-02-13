import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> checkEmailVerify(String email) async {
  // const baseUrl = "http://127.0.0.1:5000";
  const baseUrl = "http://10.0.2.2:5000";
  const path = "/check_email_available";
  final uri = Uri.parse('$baseUrl$path?email=$email');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        return false;
      } else {
        return true;
      }
    }
  } catch (e) {
    return true;
  }
  return false;
}
