import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/app_bar/custom_app_bar.dart';
import 'package:typed/review/data/models/lock_enum.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/review/ui/components/bordered_empty_container.dart';
import 'package:typed/review/ui/screens/review_error_screen.dart';
import 'package:typed/review/ui/screens/review_loading_screen.dart';
import 'package:typed/review/ui/widgets/index.dart';
import 'package:typed/review/ui/widgets/review_delete_alert_dialog.dart';
import 'package:typed/review/viewmodels/review_providers.dart';

class ReviewListScreen extends ConsumerStatefulWidget {
  const ReviewListScreen({super.key});

  @override
  ConsumerState<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends ConsumerState<ReviewListScreen>
    with SingleTickerProviderStateMixin {
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
      loading: () => ReviewLoadingScreen(
        loadingScreenTitle: '서평 목록',
      ),
      error: (error, stackTrace) => ReviewErrorScreen(
        onBackButtonTap: () => Navigator.of(context).canPop(),
        onRefreshButtonTap: () => debugPrint('새로고침'),
      ),
    );
  }

  void _handleEdit(Review review) {
    context.push(
      '/review_edit',
      extra: review,
    );
  }

  Future<void> _handleDelete(Review review) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ReviewDeleteAlertDialog(
        onDeleteButtonPressed: () {
          if (context.canPop()) {
            context.pop(true);
          } else {
            Navigator.of(context, rootNavigator: true).pop(true);
          }
        },
      ),
    );

    if (confirmed != true || !mounted) return;

    final isDeleteSuccess = await ref
        .read(ReviewProviders.reviewListProvider.notifier)
        .deleteReview(review);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isDeleteSuccess
              ? '서평이 성공적으로 삭제되었습니다.'
              : '오류로 인해 서평이 삭제되지 않았습니다.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
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
