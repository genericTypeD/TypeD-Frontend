import 'package:flutter/material.dart';
import 'package:typed/common/const/app_themes.dart';

class FeedSort extends StatelessWidget {
  final bool isPublic;
  final VoidCallback onToggle;

  const FeedSort({super.key, required this.isPublic, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onToggle,
          child: Text(
            isPublic ? '서평메모' : '문장수집',
            style: AppTheme.body1,
          ),
        ),
      ],
    );
  }
}
