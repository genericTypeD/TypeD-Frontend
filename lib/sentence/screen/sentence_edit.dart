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
      ),
    );
  }
}
