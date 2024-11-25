import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<void> sendResetToken(String email) async {
  final response = await http.post(
    Uri.parse('http://localhost/api/forgot_password.php'),
    body: {'email': email},
  );
  if (response.statusCode == 200) {
    if (kDebugMode) {
      print('Token sent to email');
    }
  } else {
    if (kDebugMode) {
      print('Failed to send token');
    }
  }
}

Future<void> verifyToken(String token) async {
  final response = await http.post(
    Uri.parse('http://localhost/api/forgot_password.php'),
    body: {'token': token},
  );
  if (response.statusCode == 200) {
    if (kDebugMode) {
      print('Token verified');
    }
  } else {
    if (kDebugMode) {
      print('Invalid token');
    }
  }
}

Future<void> resetPassword(String token, String newPassword) async {
  final response = await http.post(
    Uri.parse('http://localhost/api/forgot_password.php'),
    body: {'token': token, 'password': newPassword},
  );
  if (response.statusCode == 200) {
    if (kDebugMode) {
      print('Password reset successfully');
    }
  } else {
    if (kDebugMode) {
      print('Failed to reset password');
    }
  }
}
