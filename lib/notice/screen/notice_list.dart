import 'package:flutter/material.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('여기는 알림 페이지입니다.'),
      ),
    );
  }
}
