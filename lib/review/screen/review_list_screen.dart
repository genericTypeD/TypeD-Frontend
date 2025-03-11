import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/app_bar/custom_app_bar.dart';
import 'package:typed/review/models/lock_enum.dart';
import 'package:typed/review/models/review_model.dart';
import 'package:typed/review/viewmodels/review/review_providers.dart';

class ReviewListScreen extends ConsumerStatefulWidget {
  const ReviewListScreen({super.key});

  @override
  ConsumerState<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends ConsumerState<ReviewListScreen>
    with SingleTickerProviderStateMixin {
  static const _reviewListScreenTitle = '서평 목록';
  static const _reviewEmptyListText = '저장된 서평이 없습니다';

  late LockStatus _currentLockState;

  @override
  void initState() {
    super.initState();
    _currentLockState = LockStatus.closed;

    Future.microtask(() {
      ref.read(reviewListProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(reviewListProvider);

    return reviewsState.when(
      data: (reviews) {
        // final privateReviews = ref.watch(privateReviewsProvider);
        // final publicReviews = ref.watch(publicReviewsProvider);
        final privateReviews = ref.watch(dummyPrivateReviewsProvider);
        final publicReviews = ref.watch(dummyPublicReviewsProvider);

        final displayReviews = _currentLockState == LockStatus.closed
            ? privateReviews
            : publicReviews;

        return DefaultLayout(
          backgroundColor: AppColors.backgroundSecondary,
          appBar: _buildAppbar(),
          child: Row(
            children: [
              Container(
                width: AppBarStyle.borderContainerWidth,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  border: Border(right: AppBarStyle.borderStyle),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SafeArea(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: AppBarStyle.borderStyle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.backgroundSecondary,
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                      child: _buildReviewList(displayReviews),
                    ),
                  ),
                ),
              ),
              Container(
                width: AppBarStyle.borderContainerWidth,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  border: Border(left: AppBarStyle.borderStyle),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SafeArea(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: AppBarStyle.borderStyle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => _buildLoadingScreen(),
      error: (error, stackTrace) => _buildErrorScreen(),
    );
  }

  Widget _buildReviewList(List<dynamic> reviews) {
    if (reviews.isEmpty) {
      return _buildEmptyReviewListScreen();
    }

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
              ListTile(
                leading: review.thumbnail?.isNotEmpty ?? false
                    ? Image.network(
                        review.thumbnail!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, _) =>
                            _buildPlaceholder(0.06),
                      )
                    : _buildPlaceholder(0.06),
                title: Text(
                  review.bookTitle,
                  style: AppTheme.body1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  review.createdAt != null
                      ? 'createdAt: ${review.createdAt!.substring(0, 10)}'
                      : '',
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

              // 액션 버튼
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () {
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
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => _buildAlertDialog(),
                        );

                        if (confirmed == true) {
                          await ref
                              .read(reviewListProvider.notifier)
                              .deleteReview(review.id!);
                        }
                      },
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

  Widget _buildAlertDialog() {
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
                  onPressed: () => Navigator.pop(context, false),
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
                  onPressed: () => Navigator.pop(context, true),
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

  Widget _buildEmptyReviewListScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlaceholder(0.1),
          const SizedBox(height: 16),
          Text(
            _reviewEmptyListText,
            style: AppTheme.body2,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(double size) {
    return Image.asset(
      'assets/images/grid_item_placeholder.png',
      width: MediaQuery.of(context).size.width * size,
      height: MediaQuery.of(context).size.width * size,
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

  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      bottomLeftWidget: Text(
        _reviewListScreenTitle,
        style: AppTheme.title3,
        textAlign: TextAlign.left,
      ),
      bottomRightWidget: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: DropdownButton<LockStatus>(
          value: _currentLockState,
          alignment: Alignment.centerRight,
          style: AppTheme.title3,
          dropdownColor: Colors.white,
          elevation: 0,
          icon: Container(),
          underline: Container(),
          items: [
            DropdownMenuItem<LockStatus>(
              value: LockStatus.closed,
              child: Row(
                children: [
                  const Icon(Icons.lock_outline, size: 14),
                  const SizedBox(width: 6),
                  Text(LockStatus.closed.korName),
                ],
              ),
            ),
            DropdownMenuItem<LockStatus>(
              value: LockStatus.open,
              child: Row(
                children: [
                  const Icon(Icons.lock_open, size: 14),
                  const SizedBox(width: 6),
                  Text(LockStatus.open.korName),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _currentLockState = value;
              });
            }
          },
        ),
      ),
    );
  }
}
