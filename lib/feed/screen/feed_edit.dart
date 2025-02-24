import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';

class FeedEdit extends StatefulWidget {
  const FeedEdit({super.key});

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
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
                child: Text("취향 탐색 리스트 입니다."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
