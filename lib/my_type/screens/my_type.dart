import 'package:flutter/material.dart';

class MyTypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Type"),
      ),
      body: const Center(
        child: Text("My Type 페이지입니다."),
      ),
    );
  }
}
