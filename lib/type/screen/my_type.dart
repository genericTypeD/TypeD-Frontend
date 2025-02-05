import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class MyType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F2),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // 화살표 아이콘
            size: 20.0, // 아이콘 크기
            color: Colors.black, // 아이콘 색상
          ),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 동작
          },
        ),
        title: const Text(
          "My Type",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      child: const Center(
        child: Text("My type 페이지입니다."),
      ),
    );
  }
}
