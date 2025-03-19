import 'dart:io';
import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/core/exceptions/image_exception.dart';
import 'package:typed/review/ui/components/index.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/core/services/image_service.dart';

class GridItemContainer extends StatelessWidget {
  final GridItem item;
  final VoidCallback onTap;

  const GridItemContainer({
    required this.item,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        child: GridItemContentWidget.create(item, onTap),
      ),
    );
  }
}

abstract class GridItemContentWidget extends StatelessWidget {
  final GridItem item;

  const GridItemContentWidget({
    required this.item,
    super.key,
  });

  static GridItemContentWidget create(GridItem item, VoidCallback onTap) {
    switch (item.type) {
      case GridItemType.empty:
        return EmptyGridItemWidget(item: item);
      case GridItemType.image:
        return ImageGridItemWidget(item: item);
      case GridItemType.music:
        return MusicGridItemWidget(item: item);
      case GridItemType.bookReview:
        return BookReviewGridItemWidget(item: item);
      case GridItemType.sentence:
        return SentenceGridItemWidget(item: item);
    }
  }

  Widget _buildCustomPlaceholder() {
    return Center(
      child: CustomPlaceholder(size: 0.06),
    );
  }
}

/// 1. Empty
class EmptyGridItemWidget extends GridItemContentWidget {
  const EmptyGridItemWidget({
    super.key,
    required super.item,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCustomPlaceholder();
  }
}

/// 2. Image
class ImageGridItemWidget extends GridItemContentWidget {
  const ImageGridItemWidget({
    super.key,
    required super.item,
  });

  @override
  Widget build(BuildContext context) {
    if (!item.isImage || !item.isValid) {
      return _buildCustomPlaceholder();
    }

    return FutureBuilder<File?>(
      future: _loadImageFile(item.imagePath!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data != null) {
          return Image.file(
            snapshot.data!,
            fit: BoxFit.cover,
            errorBuilder: (buildContext, object, stackTrace) =>
                _buildCustomPlaceholder(),
          );
        }

        if (snapshot.hasError) {
          debugPrint('[Image Loading Error] ${snapshot.error}');
        }

        return _buildCustomPlaceholder();
      },
    );
  }

  Future<File?> _loadImageFile(String relativePath) async {
    try {
      if (ImageService.isValidImagePath(relativePath)) {
        final absolutePath = await ImageService.getAbsolutePath(relativePath);

        final file = File(absolutePath);
        final exists = await file.exists();

        if (exists) {
          return file;
        } else {
          throw ImageException('이미지 파일을 찾을 수 없습니다.');
        }
      }

      return null;
    } on ImageException catch (error) {
      debugPrint('[Image Exception] ${error.message}');
      return null;
    } catch (error) {
      debugPrint('[Image Loading Error] $error');
      return null;
    }
  }
}

/// 3. Music
class MusicGridItemWidget extends GridItemContentWidget {
  const MusicGridItemWidget({
    super.key,
    required super.item,
  });

  @override
  Widget build(BuildContext context) {
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

    return _buildCustomPlaceholder();
  }
}

/// 4. BookReview
class BookReviewGridItemWidget extends GridItemContentWidget {
  const BookReviewGridItemWidget({
    super.key,
    required super.item,
  });

  @override
  Widget build(BuildContext context) {
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

    return _buildCustomPlaceholder();
  }
}

/// 5. Sentence
class SentenceGridItemWidget extends GridItemContentWidget {
  const SentenceGridItemWidget({
    super.key,
    required super.item,
  });

  @override
  Widget build(BuildContext context) {
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

    return _buildCustomPlaceholder();
  }
}
