class BookSearchException implements Exception {
  final String message;
  final int? statusCode;

  const BookSearchException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}
