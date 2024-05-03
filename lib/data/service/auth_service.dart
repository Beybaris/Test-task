import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = '';

  Future<void> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sign in');
    }
  }
}
