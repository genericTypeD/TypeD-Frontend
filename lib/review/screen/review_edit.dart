import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class ReviewEdit extends StatelessWidget {
  const ReviewEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text("서평 메모 내용 편집 페이지입니다."),
      ),
    );
  }
}
