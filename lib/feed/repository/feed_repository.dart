import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typed/feed/model/feed_model.dart';
import 'package:uuid/uuid.dart' show Uuid;

class FeedRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://43.201.193.230',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  /// 디바이스 ID 가져오기 (헤더에 추가)
  Future<Map<String, dynamic>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      deviceId = const Uuid().v4();
      await prefs.setString('device_id', deviceId);
    }

    print('ID 요청 헤더 - X-Device-Id: $deviceId');

    return {'X-Device-Id': deviceId};
  }

  /// `/feed` 엔드포인트 호출 (공개 여부 필터링 없이 전체 데이터 가져옴 추후 공개게시글만)
  Future<List<FeedModel>> fetchFeed() async {
    try {
      final headers = await _getHeaders();
      final response =
          await _dio.get('/feed', options: Options(headers: headers));

      print('🔍 서버 응답 상태 코드: ${response.statusCode}');
      print('🔍 서버 응답 데이터: ${response.data}');

      if (response.statusCode != 200) {
        print('❌ 서버 오류: 상태 코드 ${response.statusCode}');
        return [];
      }

      return (response.data as List)
          .map((json) => json != null
              ? FeedModel.fromJson(json as Map<String, dynamic>)
              : null)
          .whereType<FeedModel>()
          .toList();
    } on DioException catch (e) {
      if (e.error is SocketException) {
        print('❌ 네트워크 연결 오류: 인터넷을 확인하세요.');
      } else {
        print('❌ Dio 오류: ${e.message}');
      }
      return [];
    } catch (e) {
      print('❌ 알 수 없는 오류: $e');
      return [];
    }
  }
}
