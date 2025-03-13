import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/config/env.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/data/repositories/review_repository.dart';
import 'package:typed/review/viewmodels/review_list_notifier.dart';

/// SSL 인증서 검증을 우회하는 HttpClient 객체 생성 메소드
HttpClient createUnsecureClient() {
  HttpClient client = HttpClient() // 네트워크 요청을 처리하는 기본 클라이언트 객체
    ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
        true; // 모든 SSL 인증서를 유효하다고 간주하여 인증서 검증 우회
  // IOClient로 래핑해서 http.Client 인터페이스 제공
  return client; // 인증서 검증 우회 객체 리턴
}

/// 인증서 검증을 우회하는 Dio 인스턴스 생성 메소드
Dio createDioWithoutCertVerification() {
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

/// 서평 Repository Provider
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

/// 서평 목록 상태 관리 Provider
final reviewListProvider =
    StateNotifierProvider<ReviewListNotifier, AsyncValue<List<Review>>>((ref) {
  final repository = ref.read(reviewRepositoryProvider);
  return ReviewListNotifier(repository);
});

/// 공개 서평 필터링 Provider
final publicReviewsProvider = Provider<List<Review>>((ref) {
  final reviewsState = ref.watch(reviewListProvider);
  return reviewsState.when(
    data: (reviews) => reviews.where((review) => review.isPublic).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

/// 비공개 서평 필터링 Provider
final privateReviewsProvider = Provider<List<Review>>((ref) {
  final reviewsState = ref.watch(reviewListProvider);
  return reviewsState.when(
    data: (reviews) => reviews.where((review) => !review.isPublic).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});
