import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';

class ReviewErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onBackButtonTap;
  final VoidCallback? onRefreshButtonTap;

  const ReviewErrorScreen._({
    required this.message,
    this.onBackButtonTap,
    this.onRefreshButtonTap,
    super.key,
  });

  factory ReviewErrorScreen.error({
    required VoidCallback onRefreshButtonTap,
    Key? key,
  }) {
    return ReviewErrorScreen._(
      message: '오류가 발생했습니다.',
      onRefreshButtonTap: onRefreshButtonTap,
      key: key,
    );
  }

  factory ReviewErrorScreen.invalidAccess({
    required VoidCallback onBackButtonTap,
    required VoidCallback onRefreshButtonTap,
    Key? key,
  }) {
    return ReviewErrorScreen._(
      message: '잘못된 접근입니다.',
      onBackButtonTap: onBackButtonTap,
      onRefreshButtonTap: onRefreshButtonTap,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: onRefreshButtonTap,
          child: Text(
            // '돌아가기',
            '새로고침',
            style: AppTheme.title3,
            textAlign: TextAlign.left,
          ),
        ),
        // bottomRightWidget: GestureDetector(
        //   onTap: () => onRefreshButtonTap(),
        //   child: Padding(
        //     padding: const EdgeInsets.only(right: 16),
        //     child: Text(
        //       '새로고침',
        //       style: AppTheme.title3,
        //       textAlign: TextAlign.left,
        //     ),
        //   ),
        // ),
      ),
      child: Center(
        child: Text(
          message,
          style: AppTheme.body1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
