import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotify/spotify.dart';
import 'package:typed/review/models/review_model.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/models/grid_state.dart';

final gridProvider = StateNotifierProvider<GridViewModel, GridState>((ref) {
  return GridViewModel();
});

class GridViewModel extends StateNotifier<GridState> {
  GridViewModel() : super(GridState.initial());

  /// 그리드 아이템 업데이트
  void updateGridItem(int verticalIndex, int horizontalIndex, GridItem data) {
    final newItems = List<List<GridItem>>.from(state.items);
    newItems[verticalIndex][horizontalIndex] = data;
    state = GridState(items: newItems);
  }

  /// 문장 타입으로 변경 및 데이터 설정
  // void setSentence(int verticalIndex, int horizontalIndex, String content) {
  void setSentence(int verticalIndex, int horizontalIndex, Sentence sentence) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.sentence,
      // sentenceContent: content,
      sentence: sentence,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 책 타입으로 변경 및 데이터 설정
  void setBook(int verticalIndex, int horizontalIndex, Review bookReview) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.bookReview,
      bookReview: bookReview,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 음악 타입으로 변경 및 데이터 설정
  void setMusic(int verticalIndex, int horizontalIndex, Track track) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.music,
      track: track,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 이미지 타입으로 변경 및 데이터 설정
  void setImage(int verticalIndex, int horizontalIndex, XFile imageFile) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.image,
      imageFile: imageFile,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 그리드 아이템 초기화
  void clearItem(int verticalIndex, int horizontalIndex) {
    final id = state.items[verticalIndex][horizontalIndex].id;

    updateGridItem(
      verticalIndex,
      horizontalIndex,
      GridItem.empty(id: id),
    );
  }
}
