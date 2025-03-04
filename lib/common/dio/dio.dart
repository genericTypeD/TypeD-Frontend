// lib/common/dio/dio.dart

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:typed/common/const/data.dart';

class CustomDio {
  static final dio = Dio();
  static final storage = FlutterSecureStorage();

  static Future<void> init() async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // API 요청시 저장된 토큰을 가져와서 헤더에 추가
          final token = await storage.read(key: ACCESS_TOKEN_KEY);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
              if (refreshToken == null) {
                return handler.next(error);
              }

              final response = await dio.post(
                '$baseUrl/auth/refreshToken',
                data: {
                  'refreshToken': refreshToken,
                },
              );

              final newAccessToken = response.data['accessToken'];
              await storage.write(key: ACCESS_TOKEN_KEY, value: newAccessToken);

              error.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              final retryResponse = await dio.fetch(error.requestOptions);
              return handler.resolve(retryResponse);
            } catch (e) {
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }
}
