import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class SentenceList extends StatelessWidget {
  const SentenceList({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text("문장 리스트 페이지입니다."),
      ),
    );
  }
}
