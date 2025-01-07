import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static const String fontFamily = 'Pretendard';

  // Heading 스타일
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    fontSize: 28,
    height: 34 / 28, // lineHeight 적용
    letterSpacing: 0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.blackPrimary,
    fontSize: 24,
    height: 30 / 24,
    letterSpacing: 0.5,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.blackPrimary,
    fontSize: 20,
    height: 26 / 20,
    letterSpacing: 0.5,
  );

  // title 스타일
  static const TextStyle title1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    fontSize: 20,
    height: 26 / 20,
    letterSpacing: 0.5,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    fontSize: 18,
    height: 22 / 18,
    letterSpacing: 0.5,
  );

  static const TextStyle title3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 0.5,
  );

  static const TextStyle title4 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 0.5,
  );

  // body 스타일
  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    fontSize: 15,
    height: 18 / 15,
    letterSpacing: 0.5,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    color: AppColors.blackPrimary,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.5,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    color: AppColors.blackPrimary,
    fontSize: 12,
    height: 17 / 12,
    letterSpacing: 0.5,
  );

  // caption 스타일
  static const TextStyle caption1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    fontSize: 10,
    height: 16 / 10,
    letterSpacing: 0.5,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.blackPrimary,
    fontSize: 10,
    height: 16 / 10,
    letterSpacing: 0.5,
  );
}
