import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/ui/components/custom_progress_indicator.dart';

class ReviewLoadingScreen extends StatelessWidget {
  final String loadingScreenTitle;

  const ReviewLoadingScreen({
    required this.loadingScreenTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: Text(
          loadingScreenTitle,
          style: AppTheme.title3,
          textAlign: TextAlign.left,
        ),
      ),
      child: CustomProgressIndicator(),
    );
  }
}
