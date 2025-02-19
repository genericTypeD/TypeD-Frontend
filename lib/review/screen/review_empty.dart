import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';

class ReviewEmpty extends StatelessWidget {
  const ReviewEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: Text(
            "텍스트A",
            style: AppTheme.title3,
          ),
        ),
        bottomRightWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Text(
                "글쓰기",
                style: AppTheme.title3,
              ),
            ),
          ),
        ),
      ),
      child: Container(
        color: AppColors.backgroundSecondary,
        child: const Column(
          children: [
            Expanded(
              child: Center(
                child: Text("서평메모를 해볼까요?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
