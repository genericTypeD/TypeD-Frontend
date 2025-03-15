import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:typed/review/data/models/book_model.dart';
import 'package:typed/review/data/repositories/book_search_exceptions.dart';

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
  Future<List<Book>> searchBooks(
    String query, {
    int page = _kakaoDefaultPage,
    int size = _kakaoDefaultPageSize,
    String sort = 'accuracy',
    String? target,
  }) async {
    _validateSearchParams(query, page, size);

    try {
      final response = await _executeRequest(
        query,
        page,
        size,
        sort,
        target,
      );
      return _processResponse(response);
    } on BookSearchException {
      rethrow;
    } catch (error) {
      debugPrint('[책 검색 예외 발생] ${error.toString()}');
      throw BookSearchException(
        message: '책 검색 중 오류가 발생했습니다: ${error.toString()}',
      );
    }
  }

  /// 검색 파라미터 유효성 검증 메소드
  void _validateSearchParams(
    String query,
    int page,
    int size,
  ) {
    if (query.isEmpty) {
      debugPrint('[] Empty Query');
      throw BookSearchException(
        message: '검색어는 비어있을 수 없습니다.',
      );
    }

    if (page < 1 || page > 50) {
      debugPrint('[Invalid Search Params] Out of Page Number');
      throw BookSearchException(
        message: '페이지 번호는 1-50 사이여야 합니다.',
      );
    }

    if (size < 1 || size > 50) {
      debugPrint('[Invalid Search Params] Out of Document Size');
      throw BookSearchException(
        message: '페이지당 결과 수는 1-50 사이여야 합니다.',
      );
    }
  }

  /// HTTP 요청 메소드
  Future<http.Response> _executeRequest(
    String query,
    int page,
    int size,
    String sort,
    String? target,
  ) async {
    final queryParams = {
      'query': query,
      'page': page.toString(),
      'size': size.toString(),
      'sort': sort,
    };

    if (target != null && target.isNotEmpty) {
      queryParams['target'] = target;
    }

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
    debugPrint('[책 검색 요청 URI] $uri');

    try {
      return await _client.get(
        uri,
        headers: {
          'Authorization': 'KakaoAK $_kakaoApiKey',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw BookSearchException(
          message: '요청 시간(10s)이 초과되었습니다. 네트워크 연결을 확인해주세요.',
        ),
      );
    } on http.ClientException catch (error) {
      debugPrint('[네트워크 요청 오류] ${error.toString}');
      throw BookSearchException(
        message: '네트워크 요청 중 오류가 발생했습니다.',
      );
    } catch (error) {
      rethrow;
    }
  }

  /// 응답 처리 메소드
  List<Book> _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    // HTTP 상태 코드별 처리
    switch (statusCode) {
      case 200:
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final List<dynamic> documents = data['documents'];
          return documents.map((doc) => Book.fromJson(doc)).toList();
        } catch (error) {
          debugPrint('[JSON 파싱 오류] ${error.toString()}');
          throw BookSearchException(
            message: '응답 데이터를 JSON 파싱 처리하는 중 오류가 발생했습니다.',
            statusCode: statusCode,
          );
        }

      case 400: // Bad Request
        throw BookSearchException(
          message: '잘못된 요청입니다. 검색어나 파라미터를 확인해주세요.',
          statusCode: statusCode,
        );

      case 401: // Unauthorized
        throw BookSearchException(
          message: 'API 키가 유효하지 않거나 만료되었습니다.',
          statusCode: statusCode,
        );

      case 403: // Forbidden
        throw BookSearchException(
          message: '해당 API에 대한 접근 권한이 없습니다.',
          statusCode: statusCode,
        );

      case 429: // Too Many Requests
        throw BookSearchException(
          message: 'API 호출 한도를 초과했습니다.',
          statusCode: statusCode,
        );

      case 500: // Internal Server Error
      case 502: // Bad Gateway
      case 503: // Service Unavailable
        throw BookSearchException(
          message: '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.',
          statusCode: statusCode,
        );

      default:
        debugPrint(
            '[책 검색 실패] statusCode: ${response.statusCode}, body: ${response.body}');
        throw BookSearchException(
          message: '책 검색에 실패했습니다. (상태 코드: $statusCode)',
          statusCode: statusCode,
        );
    }
  }

  /// 리소스 해제 메소드
  void dispose() {
    _client.close();
  }
}
