import 'package:flutter/material.dart';
import 'dart:io';
import 'package:typed/common/const/index.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/viewmodels/grid_viewmodel.dart';
import 'package:typed/type/views/component/add_record_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridItemWidget extends ConsumerWidget {
  final int verticalIndex;
  final int horizontalIndex;
  final double width;

  const GridItemWidget({
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
        item,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.backgroundTertiary,
          border: Border.all(
            color: AppColors.borderBlack,
            width: 0.3,
          ),
        ),
        margin: const EdgeInsets.all(8),
        child: _buildContent(item, context),
      ),
    );
  }

  Widget _buildContent(GridItem item, BuildContext context) {
    if (item.isEmpty) {
      return _buildPlaceholder(context);
    }

    switch (item.type) {
      /// 빈 GridItem
      case GridItemType.empty:
        return _buildPlaceholder(context);

      /// 이미지
      case GridItemType.image:
        if (item.imageFile != null) {
          return Image.file(
            File(item.imageFile!.path),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('[Image Loading Error] $error');
              return _buildPlaceholder(context);
            },
          );
        }
        return _buildPlaceholder(context);

      /// 음악
      case GridItemType.music:
        if (item.track != null &&
            item.isValid &&
            item.isMusic &&
            item.track!.album != null &&
            item.track!.album!.images != null &&
            item.track!.album!.images!.isNotEmpty &&
            item.track!.album!.images!.first.url != null) {
          return Image.network(
            item.track!.album!.images!.first.url!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('[Music Cover Loading Error] $error');
              return _buildPlaceholder(context);
            },
          );
        }
        return _buildPlaceholder(context);

      // 책
      case GridItemType.bookReview:
        // TODO: - if 분기문에 item 메소드로 정리
        if (item.bookReview != null &&
            item.bookReview!.thumbnail != null &&
            item.bookReview!.thumbnail!.isNotEmpty) {
          return Image.network(
            item.bookReview!.thumbnail!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('[Book Cover Loading Error] $error');
              return _buildPlaceholder(context);
            },
          );
        }
        return _buildPlaceholder(context);

      // 문장
      case GridItemType.sentence:
        // if (item.sentenceContent != null) {
        if (item.isSentence && item.isValid) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              item.sentence!.content,
              style: AppTheme.body3.copyWith(color: Colors.black),
              overflow: TextOverflow.clip,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
          );
        }
        return _buildPlaceholder(context);
    }
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/grid_item_placeholder.png',
        width: MediaQuery.of(context).size.width * 0.06,
        height: MediaQuery.of(context).size.width * 0.06,
      ),
    );
  }

  void _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    GridItem item,
  ) async {
    final result = await showDialog<GridItem>(
      context: context,
      builder: (context) => AddRecordDialog(
        item: item,
      ),
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
