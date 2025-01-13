class Sentence {
  final String content; // 문장의 내용
  final bool isPublic; // 공개 여부
  final DateTime createdAt; // 문장이 생성된 날짜

  Sentence({
    required this.content,
    required this.isPublic,
    required this.createdAt,
  });

  // 데이터를 JSON 형식으로 변환
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'isPublic': isPublic,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // JSON 데이터를 Sentence 객체로 변환
  factory Sentence.fromJson(Map<String, dynamic> json) {
    return Sentence(
      content: json['content'],
      isPublic: json['isPublic'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
