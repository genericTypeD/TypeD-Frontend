// 재사용 가능한 입력 필드

import 'package:flutter/material.dart';

class SentenceInputField extends StatelessWidget {
  final TextEditingController controller;

  const SentenceInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: '당신의 취향을 채워줄 문장을 기록해보세요.',
        border: OutlineInputBorder(),
      ),
    );
  }
}
