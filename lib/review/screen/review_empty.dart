import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class ReviewEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: const Center(
        child: Text("서평 메모 페이지입니다."),
      ),
    );
  }
}
