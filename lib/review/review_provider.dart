import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/review/model/review_model.dart';
import 'package:typed/review/review_repository.dart';

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

class ReviewListNotifier extends StateNotifier<AsyncValue<List<Review>>> {
  final ReviewRepository _repository;

  ReviewListNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchReviews();
  }

  /// 서평 목록 불러오기
  Future<void> fetchReviews() async {
    state = const AsyncValue.loading(); // 로딩 상태로 변경
    try {
      final reviews = await _repository.fetchReviews();
      state = AsyncValue.data(reviews); // 데이터 설정
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); // 에러 상태 설정
    }
  }

  /// 서평 추가
  Future<void> addReview(String bookIsbn, String bookTitle, String content,
      bool isPublic, String? thumbnail) async {
    try {
      // 서버에 저장 요청
      final newReview = await _repository.saveReview(
        bookIsbn,
        bookTitle,
        content,
        isPublic,
        thumbnail,
      );
      if (newReview != null) {
        final currentReviews = state.value ?? []; // 현재 서평 목록 가져오기
        // 새 서평 추가해서 상태 업데이트
        state = AsyncValue.data(
          [...currentReviews, newReview],
        );
      }
    } catch (e) {
      debugPrint('[서평 추가 중 오류 발생] $e');
    }
  }

  /// 서평 수정
  Future<void> updateReview(int id, String content, bool isPublic) async {
    try {
      // 서버에 수정 요청
      final success = await _repository.updateReview(
        id,
        content,
        isPublic,
      );

      if (success) {
        final currentReviews = state.value ?? []; // 현재 서평 목록 가져오기
        state = AsyncValue.data(
          currentReviews.map((review) {
            if (review.id == id) {
              return Review(
                id: review.id,
                bookIsbn: review.bookIsbn,
                bookTitle: review.bookTitle,
                content: content,
                isPublic: isPublic,
                createdAt: review.createdAt,
                updatedAt: DateTime.now().toIso8601String(),
                thumbnail: review.thumbnail,
              );
            }
            return review;
          }).toList(),
        );
      }
    } catch (e) {
      debugPrint('[서평 수정 중 오류 발생] $e');
    }
  }

  /// 서평 삭제
  Future<void> deleteReview(int id) async {
    try {
      final success = await _repository.deleteReview(id); // 서버에 삭제 요청

      if (success) {
        final currentReviews = state.value ?? []; // 현재 서평 목록 가져오기

        // 해당 ID의 서평만 제외하고 상태 업데이트
        state = AsyncValue.data(
          currentReviews.where((review) => review.id != id).toList(),
        );
      }
    } catch (e) {
      debugPrint('[서평 삭제 중 오류 발생] $e');
    }
  }
}

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
