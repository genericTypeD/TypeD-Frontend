import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class SentenceEdit extends StatelessWidget {
  const SentenceEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text("문장 수집 내용 편집 페이지입니다."),
      ),
    );
  }
}
