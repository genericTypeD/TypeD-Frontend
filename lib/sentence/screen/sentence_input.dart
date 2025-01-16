import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class SentenceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: const Center(
        child: Text("수집할 문장 입력 페이지입니다."),
      ),
    );
  }
}
