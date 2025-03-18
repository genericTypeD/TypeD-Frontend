import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typed/feed/model/feed_model.dart';

class FeedRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://43.201.193.230',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// Access Token 가져오기
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  /// `/feed` API 호출 (페이징 처리 포함)
  Future<List<FeedModel>> fetchFeeds({int page = 0, int size = 20}) async {
    final token = await _getAccessToken();

    if (token == null) {
      print('❌ Access Token이 없습니다.');
      return [];
    }

    try {
      final response = await _dio.get(
        '/feeds',
        queryParameters: {'page': page, 'size': size},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode != 200) {
        print('❌ 서버 오류: 상태 코드 ${response.statusCode}');
        return [];
      }

      return (response.data['items'] as List)
          .map((json) => FeedModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      print('❌ Dio 오류: ${e.message}');
      return [];
    } catch (e) {
      print('❌ 알 수 없는 오류: $e');
      return [];
    }
  }
}
