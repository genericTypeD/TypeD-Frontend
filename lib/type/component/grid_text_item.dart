import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';

class GridItemData {
  final String? content;
  final XFile? imageFile;
  final bool isEmpty;

  GridItemData({
    this.content,
    this.imageFile,
    String? id,
  }) : isEmpty = content == null && imageFile == null;
}

class GridState {
  final List<List<GridItemData>> items;

  GridState({required this.items});

  factory GridState.initial() {
    return GridState(
      items: List.generate(
        3,
        (_) => List.generate(2, (_) => GridItemData()),
      ),
    );
  }
}

final gridProvider = StateNotifierProvider<GridNotifier, GridState>((ref) {
  return GridNotifier();
});

class GridNotifier extends StateNotifier<GridState> {
  GridNotifier() : super(GridState.initial());

  void updateGridItem(
      int verticalIndex, int horizontalIndex, GridItemData data) {
    final newItems = List<List<GridItemData>>.from(state.items);
    newItems[verticalIndex][horizontalIndex] = data;
    state = GridState(items: newItems);
  }
}

  final double width;

  const GridTextItem({
    required this.content,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blackPrimary,
          width: 0.4,
        ),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: AppTheme.body3,
            overflow: TextOverflow.clip,
            softWrap: true,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
