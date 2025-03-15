import 'package:flutter/material.dart';
import 'dart:io';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/ui/components/index.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridItemWidget extends ConsumerWidget {
  final GridItem item;
  final VoidCallback onTap;

  const GridItemWidget({
    required this.item,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
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
      return _buildCustomPlaceholder();
    }

    switch (item.type) {
      /// 빈 GridItem
      case GridItemType.empty:
        return _buildCustomPlaceholder();

      /// 이미지
      case GridItemType.image:
        if (item.imageFile != null) {
          return Image.file(
            File(item.imageFile!.path),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('[Image Loading Error] $error');
              return _buildCustomPlaceholder();
            },
          );
        }
      // TODO: - file 없는 경우

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
              return _buildCustomPlaceholder();
            },
          );
        }

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
              return _buildCustomPlaceholder();
            },
          );
        }

      /// 문장
      case GridItemType.sentence:
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
    }

    return _buildCustomPlaceholder();
  }

  Widget _buildCustomPlaceholder() {
    return Center(
      child: CustomPlaceholder(size: 0.06),
    );
  }
}
