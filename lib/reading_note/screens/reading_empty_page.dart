import 'package:flutter/material.dart';

class ReadingEmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("서평 메모"),
      ),
      body: const Center(
        child: Text("서평 메모 페이지입니다."),
      ),
    );
  }
}
