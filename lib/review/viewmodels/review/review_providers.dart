import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/review/models/review_model.dart';
import 'package:typed/review/repositories/review_repository.dart';
import 'package:typed/review/viewmodels/review/review_viewmodel.dart';

/// 서평 Repository Provider
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

/// 서평 목록 상태 관리 Provider
final reviewListProvider =
    StateNotifierProvider<ReviewListViewModel, AsyncValue<List<Review>>>((ref) {
  final repository = ref.read(reviewRepositoryProvider);
  return ReviewListViewModel(repository);
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
