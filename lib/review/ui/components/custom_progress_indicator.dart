import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.backgroundSecondary,
        color: AppColors.borderBlack,
        strokeWidth: AppSizes.borderWidth,
      ),
    );
  }
}
