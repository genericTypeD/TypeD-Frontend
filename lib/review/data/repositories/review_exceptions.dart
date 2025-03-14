class ReviewException implements Exception {
  final String message;

  ReviewException(this.message);

  @override
  String toString() => message;
}

// 특정 서평 데이터를 찾을 수 없을 때
class ReviewNotFoundException extends ReviewException {
  ReviewNotFoundException(int id)
      : super('서평을 찾을 수 없습니다. ID: ${id.toString()}');
}

// 유효하지 않은 서평 데이터일 때
class InvalidReviewException extends ReviewException {
  InvalidReviewException() : super('Review의 필수 요소들이 비어 있습니다.');
}

// Hive DB 관련
class ReviewStorageException extends ReviewException {
  ReviewStorageException(String operation)
      : super('서평 저장소 작업($operation)을 실패했습니다.');
}

// 중복된 서평 ID
class DuplicateReviewException extends ReviewException {
  DuplicateReviewException(int id)
      : super('이미 존재하는 서평 ID입니다: ${id.toString()}');
}
