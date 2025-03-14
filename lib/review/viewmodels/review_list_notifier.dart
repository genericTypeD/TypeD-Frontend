import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/data/repositories/review_exceptions.dart';
import 'package:typed/review/data/repositories/review_repository.dart';

class ReviewListNotifier extends StateNotifier<AsyncValue<List<Review>>> {
  final ReviewRepository _repository;

  ReviewListNotifier(this._repository) : super(const AsyncValue.loading()) {
    _fetchReviews();
  }

  /// 서평 목록 불러오기
  Future<void> _fetchReviews() async {
    state = AsyncValue.loading();
    try {
      final reviews = await _repository.fetchAllReviews();
      state = AsyncValue.data(reviews);
    } catch (error, stackTrace) {
      debugPrint('[서평 목록 로딩 실패] error: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// 서평 추가
  Future<bool> addReview(String bookIsbn, String bookTitle, String content,
      bool isPublic, String? thumbnail) async {
    try {
      if (!_isValidReview(
        bookIsbn,
        bookTitle,
        content,
        thumbnail,
      )) {
        throw InvalidReviewException();
      }

      final nextId = await _repository.getNextReviewId();
      final review = Review(
        id: nextId,
        bookIsbn: bookIsbn,
        bookTitle: bookTitle,
        content: content,
        isPublic: isPublic,
        createdAt: DateTime.now().toIso8601String(),
        thumbnail: thumbnail,
      ); // 새 서평 생성

      await _repository.addReview(review); // 저장소에 저장
      _fetchReviews(); // 상태 업데이트
      return true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('[서평 추가 실패] error: $error');
      return false;
    }
  }

  /// 서평 수정
  Future<bool> updateReview(int id, String content, bool isPublic) async {
    try {
      if (content.trim().isEmpty) {
        throw ReviewException('서평 내용을 입력해주세요.');
      }

      final existingReview = _repository.getReviewById(id); // 기존 서평 찾기
      if (existingReview == null) {
        throw ReviewNotFoundException(id);
      }

      final updatedReview = existingReview.copyWith(
        content: content.trim(),
        isPublic: isPublic,
        updatedAt: DateTime.now().toIso8601String(),
      ); // 업데이트된 서평

      await _repository.updateReview(updatedReview); // 저장소에 업데이트
      _fetchReviews(); // 상태 업데이트
      return true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('[서평 수정 실패] error: $error');
      return false;
    }
  }

  /// 서평 삭제
  Future<bool> deleteReview(Review reviewIdToDelete) async {
    try {
      await _repository.deleteReview(reviewIdToDelete); // 저장소에서 삭제
      _fetchReviews(); // 상태 업데이트
      return true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('[서평 삭제 실패] error: $error');
      return false;
    }
  }

  /// 유효성 검사 메소드
  bool _isValidReview(
      String bookIsbn, String bookTitle, String content, String? thumbnail) {
    // TODO: - trim 정규식 추가
    final trimmedContent = content.trim();

    return (bookIsbn.isNotEmpty &&
        bookTitle.isNotEmpty &&
        trimmedContent.isNotEmpty &&
        thumbnail != null &&
        thumbnail != '');
  }
}
