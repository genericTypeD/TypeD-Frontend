import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:typed/config/env.dart';

class NetworkUtils {
  /// SSL 인증서 검증을 우회하는 HttpClient 객체 생성 메소드
  static HttpClient createUnsecureClient() {
    HttpClient client = HttpClient() // 네트워크 요청을 처리하는 기본 클라이언트 객체
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // 모든 SSL 인증서를 유효하다고 간주하여 인증서 검증 우회
    // IOClient로 래핑해서 http.Client 인터페이스 제공
    return client; // 인증서 검증 우회 객체 리턴
  }

  /// 인증서 검증을 우회하는 Dio 인스턴스 생성 메소드
  static Dio createDioWithoutCertVerification() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.apiUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );

    // iOS, Android 등 네이티브 플랫폼에서만 인증서 검증 우회
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
          () => createUnsecureClient();
    }

    return dio;
  }
}
