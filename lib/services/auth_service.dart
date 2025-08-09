import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'https://36e2455ca447.ngrok-free.app/api/v1';
  
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String passwordHash,
    required String userType,
  }) async {
    try {
      final bodyData = {
        "username": username,
        "email": email,
        "password_hash": passwordHash,
        "user_type": userType,
      };

      Uri uri=Uri.parse('https://36e2455ca447.ngrok-free.app/api/v1/auth/register/');
      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json', // ★ 중요
        },
        body: jsonEncode(bodyData), // ★ 중요
      );
      print('status=${response.statusCode}');
      print('body=${response.body}');
      final data = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': '회원가입이 완료되었습니다.',
          'data': data,
        };
      }
      else if(response.statusCode ==400){
        return {
          'success': true,
          "message": "이미 등록된 메일입니다.",
          'data': data,
        };
      }
      else {
        return {
          'success': false,
          'message': '회원가입에 실패했습니다.',
          'error': data,
        };
      }
    } catch (e) {

      return {
        'success': false,
        'message': '$e',
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final requestBody = json.encode({
        'email': email,
        'password': password,
      });
      
      final uri = Uri.https('36e2455ca447.ngrok-free.app', '/api/v1/auth/login/');
      print('Login Request URL: $uri');
      
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: requestBody,
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': '로그인이 완료되었습니다.',
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? '로그인에 실패했습니다.',
          'error': data,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '$e',
        'error': e.toString(),
      };
    }
  }
}
