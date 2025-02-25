import 'package:flutter/material.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/app_bar/custom_app_bar.dart';

class FeedSearch extends StatefulWidget {
  const FeedSearch({super.key});

  @override
  State<FeedSearch> createState() => _FeedSearchState();
}

class _FeedSearchState extends State<FeedSearch> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: Text(
            "검색",
            style: AppTheme.title3,
          ),
        ),
      ),
      child: const Center(
        child: Text("검색 기능 구현 예정"),
      ),
    );
  }
}
