import 'package:flutter/material.dart';
import 'package:typed/common/const/app_borders.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';

class AppBarStyle {
  static const String titleAppName = 'TypeD';

  static const double appbarHeight = 100.0;
  static const double sectionHeight = 50.0;
  static const double borderContainerWidth = 16.0;
  static const double sizedBoxWidth = 16.0;
  static const Color backgroundColor = AppColors.backgroundSecondary;
  static const double bottomLeftWidgetWidthMultiplier = 0.22;

  static const BorderSide borderStyle = BorderSide(
    color: AppColors.borderBlack,
    width: 0.3,
  );

  static const Border topBorder = AppBorders.top;

  static TextStyle titleTextStyle = AppTheme.heading3;
}
