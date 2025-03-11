import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/models/lock_enum.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';

class SentenceEdit extends ConsumerStatefulWidget {
  final int sentenceId;
  final String initialContent;
  final bool isPublic;

  const SentenceEdit({
    super.key,
    required this.sentenceId,
    required this.initialContent,
    required this.isPublic,
  });

  @override
  _SentenceEditState createState() => _SentenceEditState();
}

class _SentenceEditState extends ConsumerState<SentenceEdit> {
  static const _textFieldHintText = '문장을 입력하세요...';

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
              await ref.read(sentenceListProvider.notifier).updateSentence(
                    widget.sentenceId,
                    content,
                    widget.isPublic,
                  );
              if (context.mounted) {
                context.go('/home/sentence_list');
              }
            }
          },
          child: Text('문장 수정', style: AppTheme.title3),
        ),
      ),
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
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  border: Border(bottom: AppBarStyle.borderStyle),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        maxLines: 8,
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
  }
}
