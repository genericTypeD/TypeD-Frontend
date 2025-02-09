import 'package:flutter/material.dart';
import 'package:typed/type/layout/my_type_layout.dart';

class MyMusicScreen extends StatefulWidget {
  const MyMusicScreen({super.key});

  @override
  State<MyMusicScreen> createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyTypeLayout(
      screenTheme: '음악',
    );
  }
}
