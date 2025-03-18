import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class ReviewEditTextField extends StatelessWidget {
  static const _textFieldHintText = '서평을 입력하세요...';

  final TextEditingController controller;

  const ReviewEditTextField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
    );
  }
}
