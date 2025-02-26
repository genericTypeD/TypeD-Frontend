import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
            color: Colors.black,
          ),
        ),
        title: Text("문장 수정", style: AppTheme.title2),
        actions: [
          TextButton(
            onPressed: () async {
              final content = _controller.text.trim();
              if (content.isNotEmpty) {
                await ref
                    .read(sentenceListProvider.notifier)
                    .updateSentence(widget.sentenceId, content, !_isPrivate);
                context.go('/sentence_list'); // 수정 후 목록으로 이동
              }
            },
            child: Text("완료", style: AppTheme.title3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 8,
              style: AppTheme.body1,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundSecondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                      color: AppColors.borderBlack, width: 0.3),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                  _isPrivate ? "비공개" : "공개",
                  style: AppTheme.body2.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
