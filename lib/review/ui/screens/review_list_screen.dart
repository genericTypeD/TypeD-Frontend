import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/app_bar/custom_app_bar.dart';
import 'package:typed/review/data/models/lock_enum.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/ui/components/bordered_empty_container.dart';
import 'package:typed/review/ui/widgets/empty_review_list_content.dart';
import 'package:typed/review/ui/widgets/review_list_content.dart';
import 'package:typed/review/viewmodels/review_providers.dart';

class ReviewListScreen extends ConsumerStatefulWidget {
  const ReviewListScreen({super.key});

  @override
  ConsumerState<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends ConsumerState<ReviewListScreen>
    with SingleTickerProviderStateMixin {
  static const _reviewListScreenTitle = '서평 목록';

  late LockStatus _currentLockState;

  @override
  void initState() {
    super.initState();
    _currentLockState = LockStatus.closed;

    Future.microtask(() {
      ref.read(ReviewProviders.reviewListProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(ReviewProviders.reviewListProvider);

    return reviewsState.when(
      data: (reviews) {
        final privateReviews =
            ref.watch(ReviewProviders.privateReviewsProvider);
        final publicReviews = ref.watch(ReviewProviders.publicReviewsProvider);

        final displayReviews = _currentLockState == LockStatus.closed
            ? privateReviews
            : publicReviews;

        return DefaultLayout(
          backgroundColor: AppColors.backgroundSecondary,
          appBar: _buildReviewListAppBar(),
          child: Row(
            children: [
              BorderedEmptyContainer.left(),
              Expanded(
                child: SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundTertiary,
                      border: Border(bottom: AppBarStyle.borderStyle),
                    ),
                    child: displayReviews.isEmpty
                        ? EmptyReviewListContent()
                        : ReviewListContent(
                            reviews: displayReviews,
                            onEditButtonPressed: (review) =>
                                _handleEdit(review),
                            onDeleteButtonPressed: (review) =>
                                _handleDelete(review),
                          ),
                  ),
                ),
              ),
              BorderedEmptyContainer.right(),
            ],
          ),
        );
      },
      loading: () => _buildLoadingScreen(),
      error: (error, stackTrace) => _buildErrorScreen(),
    );
  }

  // 콜백 핸들러 - 비즈니스 로직 포함
  void _handleEdit(Review review) {
    context.push(
      '/review_edit',
      extra: {
        'reviewId': review.id,
        'initialContent': review.content,
        'isPublic': review.isPublic,
        'bookTitle': review.bookTitle,
        'thumbnail': review.thumbnail,
      },
    );
  }

  Future<void> _handleDelete(Review review) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _buildAlertDialog(review),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref.read(reviewListProvider.notifier).deleteReview(review);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('서평이 성공적으로 삭제되었습니다.'),
            ),
            snackBarAnimationStyle: AnimationStyle(
              duration: Duration(seconds: 1),
            ),
          );
        }
      } catch (error) {
        if (context.mounted) {
          debugPrint('$error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('오류로 인해 서평이 삭제되지 않았습니다.'),
            ),
            snackBarAnimationStyle: AnimationStyle(
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    }
  }

  Widget _buildAlertDialog(Review review) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: LinearBorder(
          side: BorderSide(
        width: 0.3,
        color: AppColors.borderBlack,
      )),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            '서평 삭제',
            style: AppTheme.title2,
          ),
          const SizedBox(height: 8),
          Text(
            '이 서평을 삭제하시겠습니까?',
            style: AppTheme.body1,
          ),
          const SizedBox(height: 8),
          Divider(
            thickness: 0.3,
            color: AppColors.borderBlack,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop(false);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop(false);
                    }
                  },
                  child: Text(
                    '취소',
                    style: AppTheme.body2,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop(true);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop(true);
                    }
                  },
                  child: Text(
                    '삭제',
                    style: AppTheme.body2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return DefaultLayout(
      appBar: _buildLoadingErrorAppbar(),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return DefaultLayout(
      appBar: _buildLoadingErrorAppbar(),
      child: Center(
        child: Text(
          '🙏 서평 목록을 불러오는 중 오류가 발생했습니다.',
          style: AppTheme.body1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildLoadingErrorAppbar() {
    return CustomAppBar(
      bottomLeftWidget: Text(
        _reviewListScreenTitle,
        style: AppTheme.title3,
        textAlign: TextAlign.left,
      ),
    );
  }

  PreferredSizeWidget _buildReviewListAppBar() {
    return CustomAppBar(
      bottomLeftWidget: _buildLockStatusDropdownButton(),
      bottomRightWidget: _buildAddReviewButton(),
    );
  }

  Widget _buildLockStatusDropdownButton() {
    return DropdownButton<LockStatus>(
      value: _currentLockState,
      alignment: Alignment.centerLeft,
      style: AppTheme.title3,
      dropdownColor: Colors.white,
      elevation: 0,
      icon: Container(),
      underline: Container(),
      items: LockStatus.values
          .map((status) => DropdownMenuItem<LockStatus>(
                value: status,
                child: Row(
                  children: [
                    Icon(
                        status == LockStatus.closed
                            ? Icons.lock_outline
                            : Icons.lock_open,
                        size: 14),
                    const SizedBox(width: 6),
                    Text('${status.korName} 서평'),
                  ],
                ),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _currentLockState = value;
          });
        }
      },
    );
  }

  Widget _buildAddReviewButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => context.push('/book_search'),
        child: Text(
          '추가',
          style: AppTheme.title3,
        ),
      ),
    );
  }
}
