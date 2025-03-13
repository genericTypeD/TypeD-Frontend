import 'package:hive_flutter/hive_flutter.dart';
import 'package:typed/review/data/models/review_model.dart';

class ReviewRepository {
  final Box<Review> _box = Hive.box<Review>('review');

  /// 서평 저장 (POST)
  // TODO: - 새로 추가된 서평을 반환하는 것으로 에러 처리 개선
  // TODO: - catch문 내 로깅 함수 추가
  Future<String> addReview(Review review) async {
    final key = await _box.add(review);
    return key.toString();
  }

  /// 서평 전체 목록 조회 (GET)
  Future<List<Review>> fetchAllReviews() async {
    return _box.values.toList();
  }

  // TODO: - 검색 키워드가 포함된 bookTitle 혹은 content가 있는 서평 목록 조회(키워드 검색 기능)
  // TODO: - 정렬된 상태로 목록 조회

  /// ISBN으로 특정 책의 서평 목록 조회 (GET)
  Future<List<Review>> fetchReviewsByIsbn(String isbn) async {
    return _box.values.where((review) => review.bookIsbn == isbn).toList();
  }

  /// ID로 특정 서평 조회 (GET)
  Review? getReviewById(int id) {
    try {
      return _box.values.firstWhere((review) => review.id == id);
    } catch (e) {
      return null;
      // } finally {
      //   client.close();
      // }
    }
  }

  /// ID로 특정 서평의 index 조회 (GET)
  int getReviewIndex(Review reviewToSearch) {
    final index = _box.values.toList().indexWhere(
          (review) => review.id == reviewToSearch.id,
        );
    return index;
  }

  /// 서평 수정 (PUT)
  Future<void> updateReview(Review reviewToUpdate) async {
    final index = getReviewIndex(reviewToUpdate); // 해당 ID의 서평을 찾아 인덱스 확인

    if (index != -1) {
      await _box.putAt(index, reviewToUpdate); // 해당 인덱스의 서평 업데이트
    } else {
      throw Exception('서평을 찾을 수 없습니다. ID: ${reviewToUpdate.id}');
    }
  }

  /// 서평 삭제 (DELETE)
  Future<void> deleteReview(Review reviewIdToDelete) async {
    final index = getReviewIndex(reviewIdToDelete); // 해당 ID의 서평을 찾아 인덱스 확인

    if (index != -1) {
      await _box.deleteAt(index); // 해당 인덱스의 서평 삭제
    } else {
      throw Exception('서평을 찾을 수 없습니다. ID: $reviewIdToDelete.id');
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
}
