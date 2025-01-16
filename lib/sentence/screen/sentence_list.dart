import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class SentenceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: const Center(
        child: Text("문장 리스트 페이지입니다."),
      ),
    );
  }
}
