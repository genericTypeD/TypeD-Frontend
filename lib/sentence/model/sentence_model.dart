import 'package:hive_flutter/hive_flutter.dart';

part 'sentence_model.g.dart';

@HiveType(typeId: 3)
class Sentence {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String content;
  @HiveField(2)
  final bool isPublic;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  final String updatedAt;

  Sentence({
    required this.id,
    required this.content,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sentence.fromJson(Map<String, dynamic> json) {
    return Sentence(
      id: json['id'],
      content: json['content'],
      isPublic: json['isPublic'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'isPublic': isPublic,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    final contentText = 'content: $content';
    final isPublicText = 'isPublic: $isPublic';
    final createdAtText = 'createdAt: $createdAt';
    final updatedAtText = 'updatedAt: $updatedAt';

    final sentenceInfoList = [
      contentText,
      isPublicText,
      createdAtText,
      updatedAtText,
    ].join(', ');

    return 'Sentence($sentenceInfoList)';
  }

  Sentence copyWith({
    int? sentenceId,
    String? sentenceContent,
    bool? sentenceIsPublic,
    String? sentenceCreatedAt,
    String? sentenceUpdatedAt,
  }) {
    return Sentence(
      id: sentenceId ?? id,
      content: sentenceContent ?? content,
      isPublic: sentenceIsPublic ?? isPublic,
      createdAt: sentenceCreatedAt ?? createdAt,
      updatedAt: sentenceUpdatedAt ?? DateTime.now().toIso8601String(),
    );
  }
}
