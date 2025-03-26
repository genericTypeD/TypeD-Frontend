import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../const/data.dart';

class AuthRepository {
  final dio = Dio();
  final storage = const FlutterSecureStorage();

  // 로그인
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final serialized = '$email:$password';
      final encoded = String.fromCharCodes(serialized.codeUnits);
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      print('Login Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 401) {
        throw Exception('아이디 또는 비밀번호가 일치하지 않습니다.');
      }

      if (response.statusCode != 200) {
        throw Exception('로그인에 실패했습니다.');
      }

      final refreshToken = response.data['refreshToken'];
      final accessToken = response.data['accessToken'];

      if (refreshToken == null || accessToken == null) {
        throw Exception('토큰 정보가 올바르지 않습니다.');
      }

      // 토큰 저장
      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

      final nickname = response.data['nickname'];
      final memberId = response.data['memberId'];
      await storage.write(key: 'USER_NICKNAME', value: nickname);
      await storage.write(key: 'USER_ID', value: memberId.toString());

      return accessToken;
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      print('DioError Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('아이디 또는 비밀번호가 일치하지 않습니다.');
      }

      throw Exception(
        e.response?.data?['message'] ?? '서버 연결에 실패했습니다.',
      );
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // 회원가입
  Future<void> signup({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/signup',
        data: {
          'email': email,
          'password': password,
          'nickname': nickname,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          // 응답 및 에러 로깅을 위한 설정
          validateStatus: (status) {
            return true; // 모든 상태 코드를 받아서 처리
          },
        ),
      );

      print('Signup Response:');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 400) {
        throw Exception(response.data['message'] ?? '잘못된 요청입니다.');
      }

      if (response.statusCode == 409) {
        throw Exception('이미 가입된 이메일입니다.');
      }

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('회원가입에 실패했습니다.');
      }

      // 성공 시 응답 데이터 처리 (필요한 경우)
      print('Signup success: ${response.data}');
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      print('DioError Response: ${e.response?.data}');

      if (e.response?.statusCode == 409) {
        throw Exception('이미 가입된 이메일입니다.');
      }

      throw Exception(
        e.response?.data?['message'] ?? '서버 연결에 실패했습니다.',
      );
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // 토큰 갱신
  Future<String> refreshToken() async {
    try {
      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
      final response = await dio.post(
        '$baseUrl/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      final newAccessToken = response.data['accessToken'];
      await storage.write(key: ACCESS_TOKEN_KEY, value: newAccessToken);

      return newAccessToken;
    } catch (e) {
      rethrow;
    }
  }

  // 로그아웃
  Future<void> logout() async {
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}
