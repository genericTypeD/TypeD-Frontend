import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/model/book_model.dart';
import 'package:typed/review/model/lock_enum.dart';
import 'package:typed/review/viewmodels/book_viewmodels.dart';
import 'package:typed/review/review_provider.dart';

class ReviewInputScreen extends ConsumerStatefulWidget {
  const ReviewInputScreen({super.key});

  @override
  ConsumerState<ReviewInputScreen> createState() => _ReviewInputScreenState();
}

class _ReviewInputScreenState extends ConsumerState<ReviewInputScreen> {
  static const _nullSelectedBookScreenBodyText = '책 정보가 없습니다.';
  static const _nullSelectedBookScreenAppbarText = '돌아가기';
  static const _reviewInputScreenTitle = '서평 작성';
  static const _reviewInputBodyText = '이 책에 대한 생각을 자유롭게 적어보세요.';
  static const _reviewComplete = '완료';

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isKeyboardVisible = false;
  bool _isPrivate = true; // true: 비공개, false: 공개

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
      });
    });

    // 포커스 해제
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedBook = ref.watch(selectedBookProvider);

    if (selectedBook == null) {
      return _buildNullSelectedBook();
    }

    return DefaultLayout(
      appBar: _buildAppbar(selectedBook),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: AppColors.backgroundSecondary,
          child: Stack(
            children: [
              _buildReviewInputHeader(selectedBook),
              _buildReviewInputBody(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(Book selectedBook) {
    return AppBar(
      backgroundColor: AppColors.backgroundSecondary,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/book_detail');
          }
        },
        icon: const Icon(
          Icons.close,
          size: 24.0,
          color: Colors.black,
        ),
      ),
      title: Text(
        _reviewInputScreenTitle,
        style: AppTheme.title2,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final content = _controller.text.trim();

            // 내용이 있을 때만 저장 처리
            if (content.isNotEmpty) {
              final isPublic = !_isPrivate; // _isPrivate 값의 반대가 isPublic 값이므로

              // 서평 저장
              await ref.read(reviewListProvider.notifier).addReview(
                    selectedBook.isbn,
                    selectedBook.title,
                    content,
                    isPublic,
                    selectedBook.thumbnail,
                  );

              // 저장 후 목록 화면으로 이동
              if (context.mounted) {
                context.go('/review_list');
              }
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            overlayColor: Colors.transparent,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          ),
          child: Text(
            _reviewComplete,
            style: AppTheme.title3,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewInputHeader(Book selectedBook) {
    return AnimatedOpacity(
      opacity: _isKeyboardVisible ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.borderBlack,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.zero,
              ),
              child: selectedBook.thumbnail.isNotEmpty
                  ? Image.network(
                      selectedBook.thumbnail,
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
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedBook.title,
                    style:
                        AppTheme.title3.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedBook.authors.join(', '),
                    style: AppTheme.body2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedBook.publisher,
                    style:
                        AppTheme.body2.copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewInputBody() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: _isKeyboardVisible ? 20.0 : 160.0,
      left: 16.0,
      right: 16.0,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              cursorHeight: 20.0,
              autofocus: false,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              style: AppTheme.body1,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundSecondary,
                hintText: _reviewInputBodyText,
                hintStyle: AppTheme.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(
                    color: AppColors.borderBlack,
                    width: 0.3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(
                    color: AppColors.borderBlack,
                    width: 0.3,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: const BorderSide(
                    color: AppColors.borderBlack,
                    width: 0.3,
                  ),
                ),
                contentPadding: const EdgeInsets.all(12.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _isPrivate = !_isPrivate;
                });
              },
              icon: Icon(
                _isPrivate ? Icons.lock_outline : Icons.lock_open,
                size: 20.0,
                color: Colors.black,
              ),
              label: Text(
                _isPrivate
                    ? LockStatus.closed.korName
                    : LockStatus.open.korName,
                style: AppTheme.body2.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextButton.styleFrom(
                overlayColor: Colors.transparent,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNullSelectedBook() {
    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () => context.go('/book_search'),
          child: Text(
            _nullSelectedBookScreenAppbarText,
            textAlign: TextAlign.left,
            style: AppTheme.title3,
          ),
        ),
      ),
      child: Center(
        child: Text(
          _nullSelectedBookScreenBodyText,
          style: AppTheme.title3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
