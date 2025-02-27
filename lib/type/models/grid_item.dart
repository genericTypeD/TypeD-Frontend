import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:image_picker/image_picker.dart';

part 'grid_item.freezed.dart';

@freezed
abstract class GridItem with _$GridItem {
  const factory GridItem({
    required String id,
    required GridItemType type,
    String? sentenceContent,
    String? bookTitle,
    String? bookAuthors,
    String? bookImagePath,
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
    required String title,
    String? authors,
    String? imagePath,
  }) =>
      GridItem(
        id: id,
        type: GridItemType.book,
        bookTitle: title,
        bookAuthors: authors,
        bookImagePath: imagePath,
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
}
