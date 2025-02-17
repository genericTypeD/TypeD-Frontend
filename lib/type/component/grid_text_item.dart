import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/type/component/add_record_dialog.dart';

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

class GridTextItem extends ConsumerWidget {
  final int verticalIndex;
  final int horizontalIndex;
  final double width;

  const GridTextItem({
    required this.verticalIndex,
    required this.horizontalIndex,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridState = ref.watch(gridProvider);
    final item = gridState.items[verticalIndex][horizontalIndex];

    return GestureDetector(
      onTap: () => _showAddDialog(
        context,
        ref,
        item.imageFile,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: item.isEmpty ? const Color(0xffF3F3F2) : Colors.white,
          border: Border.all(
            color: AppColors.borderBlack,
            width: 0.4,
          ),
        ),
        margin: const EdgeInsets.all(8),
        child: item.isEmpty
            ? Center(
                child: Image.asset(
                  'assets/images/grid_item_placeholder.png',
                  width: MediaQuery.of(context).size.width * 0.06,
                  height: MediaQuery.of(context).size.width * 0.06,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: item.imageFile != null
                    // TODO: - 이미지 확대/축소 기능
                    ? Image.file(
                        File(item.imageFile!.path),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('[Loading Image Error] $error');
                          return Center(
                            child: Image.asset(
                              'assets/images/grid_item_placeholder.png',
                              width: MediaQuery.of(context).size.width * 0.06,
                              height: MediaQuery.of(context).size.width * 0.06,
                            ),
                          );
                        },
                      )
                    : Text(
                        item.content ?? '',
                        style: AppTheme.body3,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
              ),
      ),
    );
  }

  void _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    XFile? initialImage,
  ) async {
    final result = await showDialog<GridItemData>(
      context: context,
      builder: (context) => AddRecordDialog(initialImage: initialImage),
    );

    if (result != null) {
      ref.read(gridProvider.notifier).updateGridItem(
            verticalIndex,
            horizontalIndex,
            result,
          );
    }
  }
}
