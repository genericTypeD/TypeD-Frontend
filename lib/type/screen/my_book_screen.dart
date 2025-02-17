import 'package:flutter/material.dart';
import 'package:typed/type/layout/my_type_layout.dart';

class MyBookScreen extends StatefulWidget {
  const MyBookScreen({super.key});

  @override
  State<MyBookScreen> createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyTypeLayout(
      screenTheme: '책',
    );
  }
}
