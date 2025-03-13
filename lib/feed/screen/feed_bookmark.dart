// 기존

import 'package:flutter/material.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/app_bar/custom_app_bar.dart';

class FeedBookmark extends StatefulWidget {
  const FeedBookmark({super.key});

  @override
  State<FeedBookmark> createState() => _FeedBookmarkState();
}

class _FeedBookmarkState extends State<FeedBookmark> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: Text(
            "북마크한 피드",
            style: AppTheme.title3,
          ),
        ),
      ),
      child: const Center(
        child: Text("북마크한 피드 목록 표시 예정"),
      ),
    );
  }
}
