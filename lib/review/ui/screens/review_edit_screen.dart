import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/lock_enum.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/ui/components/bordered_empty_container.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';
import 'package:typed/review/ui/widgets/review_edit_book_info_widget.dart';
import 'package:typed/review/ui/widgets/review_edit_text_field.dart';
import 'package:typed/review/ui/widgets/review_public_toggle_button.dart';
import 'package:typed/review/viewmodels/review_providers.dart';
import '../../../common/index.dart';

class ReviewEditScreen extends ConsumerStatefulWidget {
  final Review review;

  const ReviewEditScreen({
    super.key,
    required this.review,
  });

  @override
  ConsumerState<ReviewEditScreen> createState() => _ReviewEditScreenState();
}

class _ReviewEditScreenState extends ConsumerState<ReviewEditScreen> {
  late TextEditingController _reviewEditingController;
  bool _isPrivate = true;

  @override
  void initState() {
    super.initState();
    _reviewEditingController =
        TextEditingController(text: widget.review.content);
    _isPrivate = !widget.review.isPublic;
  }

  @override
  void dispose() {
    _reviewEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () => context.pop(),
          child: Text(
            '돌아가기',
            textAlign: TextAlign.left,
            style: AppTheme.title3,
          ),
        ),
        bottomRightWidget: TextButton(
          onPressed: () async => _handleEdit(),
          child: Text(
            '서평 수정',
            style: AppTheme.title3,
          ),
        ),
      ),
      child: Row(
        children: [
          BorderedEmptyContainer.left(),
          Expanded(
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  border: Border(bottom: AppBarStyle.borderStyle),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ReviewEditBookInfoWidget(
                        thumbnail: widget.review.thumbnail,
                        bookTitle: widget.review.bookTitle,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ReviewEditTextField(
                          controller: _reviewEditingController,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ReviewPublicToggleButton(
                        isPrivate: _isPrivate,
                        onPressed: () {
                          setState(() {
                            _isPrivate = !_isPrivate;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BorderedEmptyContainer.right(),
        ],
      ),
    );
  }

  void _handleEdit() async {
    final content = _reviewEditingController.text.trim();
    if (content.isNotEmpty) {
      final isEditSuccess = await _updateReviewContent(
        widget.review.id,
        content,
        widget.review.isPublic,
      );

      _showSnackBar(isEditSuccess);

      if (isEditSuccess) {
        _navigateToReviewList();
      }
    }
  }

  Future<bool> _updateReviewContent(
    int reviewId,
    String reviewContent,
    bool isPublic,
  ) async {
    try {
      await ref.read(ReviewProviders.reviewListProvider.notifier).updateReview(
            reviewId,
            reviewContent,
            isPublic,
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  void _showSnackBar(isEditSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEditSuccess ? '서평이 성공적으로 수정되었습니다.' : '오류로 인해 서평이 수정되지 않았습니다.',
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _navigateToReviewList() {
    if (mounted) {
      context.go('/home/review');
    }
  }
}
