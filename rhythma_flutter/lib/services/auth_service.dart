import 'package:dio/dio.dart';
import '../models/user.dart';
import '../utils/secure_storage.dart';
import 'api_client.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<User> register(String username, String email, String password, String? fullName) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
          'full_name': fullName,
        },
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw AuthException(_readErrorMessage(e, 'Registration failed. Please try again.'));
    }
  }

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/token',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      final token = response.data['access_token'] as String;
      await SecureStorage.saveToken(token);
      return token;
    } on DioException catch (e) {
      throw AuthException(_readErrorMessage(e, 'Login failed. Please check your details.'));
    }
  }

  Future<void> logout() async {
    await SecureStorage.deleteToken();
  }

  Future<bool> isLoggedIn() async {
    return await SecureStorage.hasToken();
  }

  String _readErrorMessage(DioException error, String fallback) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return 'Connection error. Please check your internet and try again.';
    }

    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) return detail;
      if (detail is List && detail.isNotEmpty) return detail.first.toString();
    }

    if (error.response?.statusCode != null && error.response!.statusCode! >= 500) {
      return 'Something went wrong on the server. Please try again later.';
    }

    return fallback;
  }
}

class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}
