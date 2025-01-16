import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class MyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: const Center(
        child: Text("나의 메뉴 페이지입니다."),
      ),
    );
  }
}
