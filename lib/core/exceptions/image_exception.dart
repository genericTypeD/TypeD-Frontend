class ImageException implements Exception {
  final String message;

  ImageException(this.message);

  @override
  String toString() => 'ImageException: $message';
}

/// 이미지 경로가 비어있는 경우
class EmptyImagePathException extends ImageException {
  EmptyImagePathException() : super('이미지 경로가 비어있습니다.');
}

/// 지원되지 않는 이미지 형식
class InvalidImageFormatException extends ImageException {
  InvalidImageFormatException() : super('지원되지 않는 이미지 형식입니다.');
}

/// 절대 경로인 경우
class AbsolutePathException extends ImageException {
  final String path;

  AbsolutePathException(this.path) : super('절대 경로는 사용할 수 없습니다. ($path)');
}

/// images 디렉토리 이내에 없는 경우
class IncorrectDirectoryException extends ImageException {
  final String path;

  IncorrectDirectoryException(this.path)
      : super('이미지는 images/ 디렉토리에 있어야 합니다. ($path)');
}
