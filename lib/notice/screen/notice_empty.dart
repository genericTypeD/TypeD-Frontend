import 'package:flutter/material.dart';

class NoticeEmpty extends StatelessWidget {
  const NoticeEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('알림 메세지가 없습니다.'),
      ),
    );
  }
}
