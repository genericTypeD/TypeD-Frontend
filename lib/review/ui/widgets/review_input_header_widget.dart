import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/book_model.dart';

class ReviewInputHeaderWidget extends StatelessWidget {
  final Book book;
  final bool isKeyboardVisible;

  const ReviewInputHeaderWidget({
    required this.book,
    required this.isKeyboardVisible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isKeyboardVisible ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookThumbnail(),
            const SizedBox(width: 16),
            _buildBookDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookThumbnail() {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderBlack,
          width: 0.3,
        ),
        borderRadius: BorderRadius.zero,
      ),
      child: book.thumbnail.isNotEmpty
          ? Image.network(
              book.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.book, size: 40),
                );
              },
            )
          : const Center(
              child: Icon(Icons.book, size: 40),
            ),
    );
  }

  Widget _buildBookDescription() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: AppTheme.title3.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book.authors.join(', '),
            style: AppTheme.body2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book.publisher,
            style: AppTheme.body2.copyWith(color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
