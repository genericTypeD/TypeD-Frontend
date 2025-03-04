import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:typed/review/model/book_model.dart';

/// 책 정보를 가져오는 Repository 클래스
class BookRepository {
  static const String _kakaoDefaultBaseUrl =
      'https://dapi.kakao.com/v3/search/book';
  static const int _kakaoDefaultPage = 1;
  static const int _kakaoDefaultPageSize = 20;

  final String _kakaoApiKey;
  final String _baseUrl;
  final http.Client _client;

  BookRepository({
    required String kakaoApiKey,
    String baseUrl = _kakaoDefaultBaseUrl,
    http.Client? client,
  })  : _kakaoApiKey = kakaoApiKey,
        _baseUrl = baseUrl,
        _client = client ?? http.Client();

  /// 책 검색 API
  Future<List<Book>> searchBooks(String query,
      {int page = _kakaoDefaultPage, int size = _kakaoDefaultPageSize}) async {
    try {
      final queryParams = {
        'query': query,
        'page': page.toString(),
        'size': size.toString(),
      };

      final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
        headers: {
          'Authorization': 'KakaoAK $_kakaoApiKey',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> documents = data['documents'];
        return documents.map((doc) => Book.fromJson(doc)).toList();
      } else {
        debugPrint('[책 검색 실패(${response.statusCode})] ${response.body}');
        throw Exception('[책 검색 실패] ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('[책 검색 예외 발생] ${e.toString()}');
      throw Exception('[책 검색 중 오류 발생] ${e.toString()}');
    }
  }
}
