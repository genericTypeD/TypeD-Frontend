import 'package:hive_flutter/hive_flutter.dart';

part 'review_model.g.dart';

@HiveType(typeId: 2)
class Review {
  @HiveField(0)
  final int id;

  @HiveField(2)
  final String bookIsbn;
  @HiveField(3)
  final String bookTitle;
  @HiveField(4)
  final String content;
  @HiveField(5)
  final bool isPublic;
  @HiveField(6)
  final String createdAt;
  @HiveField(7)
  final String updatedAt;
  @HiveField(8)
  final String? thumbnail;

  Review({
    required this.id,
    required this.bookIsbn,
    required this.bookTitle,
    required this.content,
    required this.isPublic,
    String? createdAt,
    String? updatedAt,
    this.thumbnail,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updatedAt ?? DateTime.now().toIso8601String();

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

  @override
  String toString() {
    final bookTitleText = 'bookTitle: $bookTitle';
    final bookIsbnText = 'bookIsbn: $bookIsbn';
    final contentText = 'content: $content';
    final isPublicText = 'isPublic: $isPublic';
    final createdAtText = 'createdAt: $createdAt';
    final thumbnailText = 'thumbnail: $thumbnail';

    final bookInfoList = [
      bookTitleText,
      bookIsbnText,
      contentText,
      isPublicText,
      createdAtText,
      thumbnailText,
    ].join(', ');

    return 'Review($bookInfoList)';
  }

  Review copyWith({
    int? bookId,
    String? bookIsbn,
    String? bookTitle,
    String? content,
    bool? isPublic,
    String? thumbnail,
    String? updatedAt,
  }) {
    return Review(
      id: bookId ?? id,
      bookIsbn: bookIsbn ?? this.bookIsbn,
      bookTitle: bookTitle ?? this.bookTitle,
      content: content ?? this.content,
      isPublic: isPublic ?? this.isPublic,
      thumbnail: thumbnail ?? this.thumbnail,
      updatedAt: updatedAt ?? DateTime.now().toIso8601String(),
    );
  }
}
