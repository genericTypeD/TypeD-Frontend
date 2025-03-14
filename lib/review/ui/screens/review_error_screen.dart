import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';

class ReviewErrorScreen extends StatelessWidget {
  final VoidCallback onBackButtonTap;
  final VoidCallback onRefreshButtonTap;

  const ReviewErrorScreen({
    required this.onBackButtonTap,
    required this.onRefreshButtonTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
          bottomLeftWidget: GestureDetector(
            onTap: () => onBackButtonTap(),
            child: Text(
              '돌아가기',
              style: AppTheme.title3,
              textAlign: TextAlign.left,
            ),
          ),
          bottomRightWidget: GestureDetector(
            onTap: () => onRefreshButtonTap(),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '새로고침',
                style: AppTheme.title3,
                textAlign: TextAlign.left,
              ),
            ),
          )),
      child: Center(
        child: Text(
          '오류가 발생했습니다.',
          style: AppTheme.body1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
