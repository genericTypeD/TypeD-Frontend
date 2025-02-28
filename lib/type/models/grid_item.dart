import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typed/type/models/book_model.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:image_picker/image_picker.dart';

part 'grid_item.freezed.dart';

@freezed
abstract class GridItem with _$GridItem {
  const factory GridItem({
    required String id,
    required GridItemType type,
    String? sentenceContent,
    Book? book,
    String? trackTitle,
    String? trackArtists,
    String? trackImagePath,
    XFile? imageFile,
  }) = _GridItem;

  const GridItem._();

  bool get isEmpty => type == GridItemType.empty;

  /// 빈 그리드 아이템 팩토리 생성자
  factory GridItem.empty({required String id}) => GridItem(
        id: id,
        type: GridItemType.empty,
      );

  /// 문장 그리드 아이템 팩토리 생성자
  factory GridItem.sentence({
    required String id,
    required String content,
  }) =>
      GridItem(
        id: id,
        type: GridItemType.sentence,
        sentenceContent: content,
      );

  /// 책 그리드 아이템 팩토리 생성자
  factory GridItem.book({
    required String id,
    required Book book,
  }) =>
      GridItem(
        id: id,
        type: GridItemType.book,
        book: book,
      );

  /// 음악 그리드 아이템 팩토리 생성자
  factory GridItem.music({
    required String id,
    required String title,
    String? artists,
    String? imagePath,
  }) =>
      GridItem(
        id: id,
        type: GridItemType.music,
        trackTitle: title,
        trackArtists: artists,
        trackImagePath: imagePath,
      );

  /// 이미지 그리드 아이템 팩토리 생성자
  factory GridItem.image({
    required String id,
    required XFile imageFile,
  }) =>
      GridItem(
        id: id,
        type: GridItemType.image,
        imageFile: imageFile,
      );

  /// 새로운 타입의 아이템으로 변환
  GridItem changeType(GridItemType newType) {
    if (type == newType) return this;

    return GridItem(
      id: id,
      type: newType,
    );
  }

  /// 타입별 유효성 확인
  bool get isSentence => type == GridItemType.sentence;
  bool get isBook => type == GridItemType.book;
  bool get isMusic => type == GridItemType.music;
  bool get isImage => type == GridItemType.image;

  /// 타입별 필요한 데이터가 있는지 확인
  bool get isValid {
    switch (type) {
      case GridItemType.empty:
        return true;
      case GridItemType.sentence:
        return (sentenceContent != null && sentenceContent!.isNotEmpty);
      case GridItemType.book:
        return (book != null);
      case GridItemType.music:
        return (trackTitle != null && trackTitle!.isNotEmpty) &&
            (trackArtists != null && trackArtists!.isNotEmpty) &&
            (trackImagePath != null && trackImagePath!.isNotEmpty);
      case GridItemType.image:
        return (imageFile != null);
    }
  }
}
