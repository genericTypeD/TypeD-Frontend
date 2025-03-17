import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';

class ReviewEditBookInfoWidget extends StatelessWidget {
  final String? thumbnail;
  final String bookTitle;

  const ReviewEditBookInfoWidget({
    required this.thumbnail,
    required this.bookTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildThumbnail(),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            bookTitle,
            style: AppTheme.title3,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    if (thumbnail != null && thumbnail!.isNotEmpty) {
      return Container(
        width: 70,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderBlack,
            width: 0.3,
          ),
          borderRadius: BorderRadius.zero,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          thumbnail!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, _) => CustomPlaceholder(size: 0.06),
        ),
      );
    } else {
      return Container(
        width: 60,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderBlack,
            width: 0.3,
          ),
          borderRadius: BorderRadius.zero,
        ),
        child: CustomPlaceholder(size: 0.06),
      );
    }
  }
}
