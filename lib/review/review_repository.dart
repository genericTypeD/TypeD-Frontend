import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:typed/review/model/review_model.dart';

http.Client createUnsecureClient() {
  HttpClient client = HttpClient() // 네트워크 요청을 처리하는 기본 클라이언트 객체
    ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
        true; // 모든 SSL 인증서를 유효하다고 간주하여 인증서 검증 우회
  // IOClient로 래핑해서 http.Client 인터페이스 제공
  return IOClient(client); // 인증서 검증 우회 객체를 http.Client로 래핑하여 리턴
}

http.Client getClient(bool isDebugMode) {
  if (isDebugMode) {
    return createUnsecureClient(); // 개발 및 테스트 환경에서만
  } else {
    return http.Client(); // 프로덕션 환경에서는 정상 검증
  }
}

class ReviewRepository {
  static const String _baseUrl = Env.apiUrl;
  static const String _deviceIdKey = 'device_id';
  static const String _reviewEndpoint = '/reviews';
  static const String _contentType = 'Content-Type';
  static const String _applicationJson = 'application/json';
  static const String _deviceIdHeader = 'X-Device-Id';

  /// 디바이스 ID 가져오기
  Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_deviceIdKey);

    if (deviceId == null) {
      deviceId = Uuid().v4();
      await prefs.setString(_deviceIdKey, deviceId);
    }

    debugPrint('사용 중인 디바이스 ID: $deviceId');
    return deviceId;
  }

  /// 서평 저장 (POST)
  Future<Review?> saveReview(String bookIsbn, String bookTitle, String content,
      bool isPublic, String? thumbnail) async {
    final String deviceId = await _getDeviceId();
    final response = await http.post(
      Uri.parse('$_baseUrl$_reviewEndpoint'),
      headers: {_contentType: _applicationJson, _deviceIdHeader: deviceId},
      body: jsonEncode({
        'bookIsbn': bookIsbn,
        'bookTitle': bookTitle,
        'content': content,
        'isPublic': isPublic,
        'thumbnail': thumbnail,
      }),
    );

    if (response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('[서평 저장 실패] ${response.body}');
      return null;
    }
  }

  /// 서평 목록 조회 (GET)
  Future<List<Review>> fetchReviews() async {
    final String deviceId = await _getDeviceId();
    final response = await http.get(
      Uri.parse('$_baseUrl$_reviewEndpoint'),
      headers: {_contentType: _applicationJson, _deviceIdHeader: deviceId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Review.fromJson(item)).toList();
    } else {
      debugPrint('[서평 목록 조회 실패] ${response.body}');
      return [];
    }
  }

  /// 서평 수정 (PUT)
  Future<bool> updateReview(int reviewId, String content, bool isPublic) async {
    final String deviceId = await _getDeviceId();
    final response = await http.put(
      Uri.parse('$_baseUrl$_reviewEndpoint$reviewId'),
      headers: {_contentType: _applicationJson, _deviceIdHeader: deviceId},
      body: jsonEncode({
        'content': content,
        'isPublic': isPublic,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('[서평 수정 실패] ${response.body}');
      return false;
    }
  }

  /// 서평 삭제 (DELETE)
  Future<bool> deleteReview(int reviewId) async {
    final String deviceId = await _getDeviceId();
    final response = await http.delete(
      Uri.parse('$_baseUrl$_reviewEndpoint/$reviewId'),
      headers: {_contentType: _applicationJson, _deviceIdHeader: deviceId},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('[서평 삭제 실패] ${response.body}');
      return false;
    }
  }
}
