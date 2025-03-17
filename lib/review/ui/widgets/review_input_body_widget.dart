import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/lock_enum.dart';

class ReviewInputBodyWidget extends StatelessWidget {
  static const _reviewInputBodyText = '이 책에 대한 생각을 자유롭게 적어보세요.';

  final bool isKeyboardVisible;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPrivate;
  final VoidCallback onPublicToggleButtonPressed;

  const ReviewInputBodyWidget({
    required this.isKeyboardVisible,
    required this.controller,
    required this.focusNode,
    required this.isPrivate,
    required this.onPublicToggleButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: isKeyboardVisible ? 20.0 : 160.0,
      left: 16.0,
      right: 16.0,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: _buildReviewInputTextField(),
          ),
          const SizedBox(height: 8.0),
          _buildReviewInputPublicToggleButton(),
        ],
      ),
    );
  }

  Widget _buildReviewInputTextField() {
    return TextField(
      focusNode: focusNode,
      controller: controller,
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
    );
  }

  Widget _buildReviewInputPublicToggleButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: onPublicToggleButtonPressed,
        icon: Icon(
          isPrivate ? Icons.lock_outline : Icons.lock_open,
          size: 20.0,
          color: Colors.black,
        ),
        label: Text(
          isPrivate ? LockStatus.closed.korName : LockStatus.open.korName,
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
    );
  }
}
