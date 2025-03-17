import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/data/repositories/review_exceptions.dart';

enum SortOption {
  id,
  bookTitle,
  createdAt,
  updatedAt,
}

class ReviewRepository {
  final Box<Review> _box = Hive.box<Review>('review');

  /// 서평 저장 (POST)
  Future<Review> addReview(Review review) async {
    try {
      await _box.add(review);
      return review;
    } catch (error) {
      final errorString = '서평 저장';

      _logError(errorString, error);
      throw ReviewStorageException(errorString);
    }
  }

  /// 서평 전체 목록 조회 (GET)
  Future<List<Review>> fetchAllReviews({
    SortOption? sortBy = SortOption.createdAt,
    bool ascending = false,
  }) async {
    try {
      List<Review> reviews = _box.values.toList();

      if (sortBy != null) {
        int comparison;

        reviews.sort((lhs, rhs) {
          switch (sortBy) {
            case SortOption.id:
              comparison = lhs.id.compareTo(rhs.id);
              break;
            case SortOption.bookTitle:
              comparison = lhs.bookTitle.compareTo(rhs.bookTitle);
              break;
            case SortOption.createdAt:
              comparison = lhs.createdAt.compareTo(rhs.createdAt);
              break;
            case SortOption.updatedAt:
              comparison = lhs.updatedAt.compareTo(rhs.updatedAt);
              break;
          }

          return ascending ? comparison : -comparison;
        });
      }

      return reviews;
    } catch (error) {
      final errorString = '서평 전체 목록 조회';

      _logError(errorString, error);
      throw ReviewStorageException(errorString);
    }
  }

  // TODO: - 검색 키워드가 포함된 bookTitle 혹은 content가 있는 서평 목록 조회(키워드 검색 기능)
  // TODO: - 정렬된 상태로 목록 조회
  /// ISBN으로 특정 책의 서평 목록 조회 (GET)
  Future<List<Review>> fetchReviewsByIsbn(String isbn) async {
    try {
      return _box.values.where((review) => review.bookIsbn == isbn).toList();
    } catch (error) {
      final errorString = 'ISBN으로 특정 책의 서평 목록 조회';

      _logError(errorString, error);
      throw ReviewStorageException(errorString);
    }
  }

  /// ID로 특정 서평 조회 (GET)
  Review? getReviewById(int id) {
    try {
      return _box.values.firstWhere((review) => review.id == id);
    } catch (error) {
      final errorString = 'ID로 특정 서평 조회';

      _logError(errorString, error);
      return null;
    }
  }

  /// ID로 특정 서평의 index 조회 (GET)
  int getReviewIndex(Review reviewToSearch) {
    try {
      final index = _box.values.toList().indexWhere(
            (review) => review.id == reviewToSearch.id,
          );
      return index;
    } catch (error) {
      final errorString = 'ID로 특정 서평의 index 조회';

      _logError(errorString, error);
      throw ReviewStorageException(errorString);
    }
  }

  /// 서평 수정 (PUT)
  Future<void> updateReview(Review reviewToUpdate) async {
    try {
      final index = getReviewIndex(reviewToUpdate); // 해당 ID의 서평을 찾아 인덱스 확인

      if (index != -1) {
        await _box.putAt(index, reviewToUpdate); // 해당 인덱스의 서평 업데이트
      } else {
        throw ReviewNotFoundException(reviewToUpdate.id);
      }
    } catch (error) {
      final errorString = '서평 수정';
      _logError(errorString, error);

      if (error is ReviewNotFoundException) {
        rethrow;
      } else {
        throw ReviewStorageException(errorString);
      }
    }
  }

  /// 서평 삭제 (DELETE)
  Future<void> deleteReview(Review reviewIdToDelete) async {
    try {
      final index = getReviewIndex(reviewIdToDelete); // 해당 ID의 서평을 찾아 인덱스 확인

      if (index != -1) {
        await _box.deleteAt(index); // 해당 인덱스의 서평 삭제
      } else {
        throw ReviewNotFoundException(reviewIdToDelete.id);
      }
    } catch (error) {
      final errorString = '서평 삭제';
      _logError(errorString, error);

      if (error is ReviewNotFoundException) {
        rethrow;
      } else {
        throw ReviewStorageException(errorString);
      }
    }
  }

  /// ID AutoIncrement용 메소드
  Future<int> getNextReviewId() async {
    if (_box.isEmpty) {
      return 1;
    }

    int maxId = 0;
    for (var review in _box.values) {
      if (review.id > maxId) {
        maxId = review.id;
      }
    }

    return maxId + 1;
  }

  // 에러 로깅 유틸리티 메소드
  void _logError(String operation, dynamic error) {
    final timestamp = DateTime.now().toIso8601String();
    final errorMessage =
        '[${timestamp}] [Repository Error] $operation 실패: $error';

    debugPrint(errorMessage);
  }
}
