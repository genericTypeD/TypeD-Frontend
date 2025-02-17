import 'package:flutter/material.dart';
import 'package:typed/type/layout/my_type_layout.dart';

class MySentenceScreen extends StatefulWidget {
  const MySentenceScreen({super.key});

  @override
  State<MySentenceScreen> createState() => _MySentenceScreenState();
}

class _MySentenceScreenState extends State<MySentenceScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyTypeLayout(
      screenTheme: '문장',
    );
  }
}
