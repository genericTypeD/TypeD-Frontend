import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/book_model.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';

class BookSearchResultWidget extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookSearchResultWidget({
    required this.book,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.backgroundTertiary,
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: AppColors.borderBlack,
                  width: 0.3,
                ),
              ),
              child: book.thumbnail.isNotEmpty
                  ? Image.network(
                      book.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: CustomPlaceholder(size: 0.06),
                        );
                      },
                    )
                  : Center(
                      child: CustomPlaceholder(size: 0.1),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBookItemText(book.title),
                  const SizedBox(height: 4),
                  _buildBookItemText(book.author),
                  const SizedBox(height: 4),
                  _buildBookItemText(book.publisher),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookItemText(String text) {
    return Text(
      text,
      style: AppTheme.body2,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
