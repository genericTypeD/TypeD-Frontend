import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/lock_enum.dart';
import 'package:typed/review/ui/components/bordered_empty_container.dart';
import 'package:typed/review/viewmodels/review_providers.dart';
import '../../../common/index.dart';

class ReviewEditScreen extends ConsumerStatefulWidget {
  final int reviewId;
  final String initialContent;
  final bool isPublic;
  final String bookTitle;
  final String? thumbnail;

  const ReviewEditScreen({
    super.key,
    required this.reviewId,
    required this.initialContent,
    required this.isPublic,
    required this.bookTitle,
    this.thumbnail,
  });

  @override
  ConsumerState<ReviewEditScreen> createState() => _ReviewEditScreenState();
}

class _ReviewEditScreenState extends ConsumerState<ReviewEditScreen> {
  static const _textFieldHintText = '서평을 입력하세요...';

  late TextEditingController _controller;
  bool _isPrivate = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
    _isPrivate = !widget.isPublic;
  }

  @override
  void dispose() {
    _controller.dispose();
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
          onPressed: () async {
            final content = _controller.text.trim();
            if (content.isNotEmpty) {
              await ref
                  .read(ReviewProviders.reviewListProvider.notifier)
                  .updateReview(
                    widget.reviewId,
                    content,
                    widget.isPublic,
                  );
              if (context.mounted) {
                context.go('/home/review');
              }
            }
          },
          child: Text('서평 수정', style: AppTheme.title3),
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
                      Row(
                        children: [
                          if (widget.thumbnail != null &&
                              widget.thumbnail!.isNotEmpty)
                            Container(
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
                                widget.thumbnail!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, _) =>
                                    _buildPlaceholder(0),
                              ),
                            )
                          else
                            Container(
                              width: 60,
                              height: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.borderBlack,
                                  width: 0.3,
                                ),
                                borderRadius: BorderRadius.zero,
                              ),
                              child: _buildPlaceholder(0),
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              widget.bookTitle,
                              style: AppTheme.title3,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          expands: true,
                          style: AppTheme.body2,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.backgroundSecondary,
                            hintText: _textFieldHintText,
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
                                width: 0.6,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                          ),
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
                            style: AppTheme.body2
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
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

  Widget _buildPlaceholder(double size) {
    return Image.asset(
      'assets/images/grid_item_placeholder.png',
      width: MediaQuery.of(context).size.width * size,
      height: MediaQuery.of(context).size.width * size,
    );
  }
}
