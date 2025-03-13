import 'package:flutter/material.dart';

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
            isPublic ? '공개된' : '내 피드',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
