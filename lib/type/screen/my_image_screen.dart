import 'package:flutter/material.dart';
import 'package:typed/type/layout/my_type_layout.dart';

class MyMovieScreen extends StatefulWidget {
  const MyMovieScreen({super.key});

  @override
  State<MyMovieScreen> createState() => _MyMovieScreenState();
}

class _MyMovieScreenState extends State<MyMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyTypeLayout(
      screenTheme: '영화',
    );
  }
}
