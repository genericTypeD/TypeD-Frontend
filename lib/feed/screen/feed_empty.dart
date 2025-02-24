import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';

class FeedEmpty extends StatefulWidget {
  const FeedEmpty({super.key});

  @override
  State<FeedEmpty> createState() => _FeedEmptyState();
}

class _FeedEmptyState extends State<FeedEmpty> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: Text(
            "취향 탐색",
            style: AppTheme.title3,
          ),
        ),
        bottomRightWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Text(
            "공개된 서평 • 공개된 문장",
            style: AppTheme.title3,
          ),
        ),
      ),
      child: Container(
        color: AppColors.backgroundSecondary,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text("이 페이지가 필요할까?? "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
