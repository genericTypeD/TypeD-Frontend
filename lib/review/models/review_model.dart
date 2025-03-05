class Review {
  final int? id; // 서버에서 할당받기 전에는 null일 수 있음
  final String bookIsbn;
  final String bookTitle;
  final String content;
  final bool isPublic;
  final String createdAt;
  final String updatedAt;
  final String? thumbnail;

  Review({
    this.id,
    required this.bookIsbn,
    required this.bookTitle,
    required this.content,
    required this.isPublic,
    String? createdAt,
    String? updatedAt,
    this.thumbnail,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  // 서버 응답에서 Review 객체 생성
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      bookIsbn: json['bookIsbn'] ?? '',
      bookTitle: json['bookTitle'] ?? '',
      content: json['content'] ?? '',
      isPublic: json['isPublic'] ?? false,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookIsbn': bookIsbn,
      'bookTitle': bookTitle,
      'content': content,
      'isPublic': isPublic,
      'thumbnail': thumbnail,
    };
  }
}
