import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/data/repositories/review_repository.dart';
import 'package:typed/review/viewmodels/review_list_notifier.dart';

class ReviewProviders {
  /// 서평 Repository Provider
  static final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
    return ReviewRepository();
  });

  /// 서평 목록 상태 관리 Provider
  static final reviewListProvider =
      StateNotifierProvider<ReviewListNotifier, AsyncValue<List<Review>>>(
          (ref) {
    final repository = ref.read(reviewRepositoryProvider);
    return ReviewListNotifier(repository);
  });

  /// 공개 서평 필터링 Provider
  static final publicReviewsProvider = Provider<List<Review>>((ref) {
    final reviewsState = ref.watch(reviewListProvider);
    return reviewsState.when(
      data: (reviews) => reviews.where((review) => review.isPublic).toList(),
      loading: () => [],
      error: (_, __) => [],
    );
  });

  /// 비공개 서평 필터링 Provider
  static final privateReviewsProvider = Provider<List<Review>>((ref) {
    final reviewsState = ref.watch(reviewListProvider);
    return reviewsState.when(
      data: (reviews) => reviews.where((review) => !review.isPublic).toList(),
      loading: () => [],
      error: (_, __) => [],
    );
  });
}
