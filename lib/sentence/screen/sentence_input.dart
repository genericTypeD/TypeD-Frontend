import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart'; // DefaultLayout 임포트

class SentenceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "문장 입력", // 제목을 지정하여 앱 바에 표시
      child: const Center(
        child: Text("수집할 문장 입력 페이지입니다."),
      ),
    );
  }
}
