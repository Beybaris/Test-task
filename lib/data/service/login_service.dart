import 'dart:convert';
import 'package:application/data/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LoginService {
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

  Future<UserModel?> login(String email, String password) async {
    var url = Uri.parse('https://test.api.qazaqmura.kz/v1/login');
    try {
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  bool isTokenExpired(String expiryDate) {
    final format = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
    final expiration = format.parse(expiryDate, true).toLocal();
    return expiration.isBefore(DateTime.now());
  }
}
