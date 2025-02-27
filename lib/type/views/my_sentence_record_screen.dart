import 'package:flutter/material.dart';
import 'package:typed/type/views/layout/my_type_layout.dart';

class MySentenceRecordScreen extends StatefulWidget {
  const MySentenceRecordScreen({super.key});

  @override
  State<MySentenceRecordScreen> createState() => _MySentenceRecordScreenState();
}

class _MySentenceRecordScreenState extends State<MySentenceRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyTypeLayout(
      screenTheme: '문장',
    );
  }
}
