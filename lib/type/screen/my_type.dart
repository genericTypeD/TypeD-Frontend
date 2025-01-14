import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';

class MyType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  GridElementWidget(title: '올해의 책', content: fillNumber(1)),
                  GridElementWidget(title: '올해의 책', content: fillNumber(1)),
                  GridElementWidget(title: '올해의 책', content: fillNumber(1)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [],
              ),
            ),
            Expanded(
              child: Row(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String fillNumber(int i) {
    return List.generate(1000, (_) => i).join();
  }
}

class GridElementWidget extends StatelessWidget {
  final String title;
  final String content;

  const GridElementWidget({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundTertiary,
          borderRadius: BorderRadius.circular(16),
        ),
        height: double.infinity,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${title}',
                style: AppTheme.heading3,
              ),
              Expanded(
                child: Text(
                  '${content}',
                  style: AppTheme.body3,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
