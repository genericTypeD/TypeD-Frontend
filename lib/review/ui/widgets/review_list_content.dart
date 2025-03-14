import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';

class ReviewListContent extends StatelessWidget {
  final List<Review> reviews;
  final Function(Review) onEditButtonPressed;
  final Function(Review) onDeleteButtonPressed;

  const ReviewListContent({
    required this.reviews,
    required this.onEditButtonPressed,
    required this.onDeleteButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];

        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            border: Border(
              bottom: AppBarStyle.borderStyle,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 서평 헤더 (책 표지 이미지 + 책 제목 + 서평 생성일)
              ListTile(
                leading: review.thumbnail?.isNotEmpty ?? false
                    ? Image.network(
                        review.thumbnail!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, _) =>
                            CustomPlaceholder(size: 0.06),
                      )
                    : CustomPlaceholder(size: 0.06),
                title: Text(
                  review.bookTitle,
                  style: AppTheme.body1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'createdAt: ${review.createdAt.substring(0, 10)}',
                  style: AppTheme.body3,
                ),
              ),

              // 서평 내용
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  review.content,
                  style: AppTheme.body2,
                ),
              ),

              // 액션 버튼들(편집 + 삭제)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => onEditButtonPressed(review),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () => onDeleteButtonPressed(review),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
