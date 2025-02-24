import 'package:flutter/material.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "서평 메모 리스트 페이지 입니다.",
          style: AppTheme.title2,
        ),
      ),
    );
  }
}
