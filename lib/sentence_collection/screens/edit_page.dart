import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  final int index;

  EditPage({required this.index}); // index 매개변수 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Sentence $index"),
      ),
      body: Center(
        child: Text("Editing Sentence $index"),
      ),
    );
  }
}
