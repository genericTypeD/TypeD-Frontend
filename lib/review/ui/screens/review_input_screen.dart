import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/data/models/book_model.dart';
import 'package:typed/review/ui/widgets/review_input_body_widget.dart';
import 'package:typed/review/ui/widgets/review_input_header_widget.dart';
import 'package:typed/review/viewmodels/book_providers.dart';
import 'package:typed/review/viewmodels/review_providers.dart';

class ReviewInputScreen extends ConsumerStatefulWidget {
  const ReviewInputScreen({super.key});

  @override
  ConsumerState<ReviewInputScreen> createState() => _ReviewInputScreenState();
}

class _ReviewInputScreenState extends ConsumerState<ReviewInputScreen> {
  static const _nullSelectedBookScreenBodyText = '책 정보가 없습니다.';
  static const _nullSelectedBookScreenAppbarText = '돌아가기';
  static const _reviewInputScreenTitle = '서평 작성';
  static const _reviewComplete = '완료';

  final TextEditingController _reviewEditingController =
      TextEditingController();
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _reviewEditingController.dispose();
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
              ReviewInputHeaderWidget(
                book: selectedBook,
                isKeyboardVisible: _isKeyboardVisible,
              ),
              ReviewInputBodyWidget(
                isKeyboardVisible: _isKeyboardVisible,
                controller: _reviewEditingController,
                focusNode: _focusNode,
                isPrivate: _isPrivate,
                onPublicToggleButtonPressed: () {
                  setState(() {
                    _isPrivate = !_isPrivate;
                  });
                },
              ),
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
            final content = _reviewEditingController.text.trim();

            if (content.isNotEmpty) {
              final isPublic = !_isPrivate;

              try {
                await ref
                    .read(ReviewProviders.reviewListProvider.notifier)
                    .addReview(
                      selectedBook.isbn,
                      selectedBook.title,
                      content,
                      isPublic,
                      selectedBook.thumbnail,
                    );

                if (context.mounted) {
                  context.go('/home/review');
                }
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('실패! (오류: $error)'),
                    ),
                  );
                }
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
