import 'package:flutter/material.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';

class ReviewInput extends StatefulWidget {
  const ReviewInput({super.key});

  @override
  State<ReviewInput> createState() => _ReviewInputState();
}

class _ReviewInputState extends State<ReviewInput> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "서평 메모\n서평 메모 서평 메모",
          style: AppTheme.title2,
        ),
      ),
    );
  }
}
