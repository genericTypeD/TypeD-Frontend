import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_model.freezed.dart';
part 'feed_model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  factory FeedModel({
    required String id, // 피드 고유 ID
    required String userId, // 작성자 ID
    required String userName, // 작성자 이름
    required String profileImageUrl, // 작성자 프로필 이미지
    required String content, // 피드 내용 (서평 or 문장)
    required String type, // "review" or "sentence"
    required bool isPublic, // 공개 여부
    required DateTime createdAt, // 작성 날짜
    List<String>? hashtags, // 해시태그 목록
    @Default(false) bool isBookmarked, // 북마크 여부
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);
}
