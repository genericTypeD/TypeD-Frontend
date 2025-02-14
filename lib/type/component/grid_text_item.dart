import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';

class GridTextItem extends StatelessWidget {
  final String content;
  final double width;

  const GridTextItem({
    required this.content,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderBlack,
          width: 0.4,
        ),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: AppTheme.body1,
            overflow: TextOverflow.clip,
            softWrap: true,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
