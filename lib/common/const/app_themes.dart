import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';

class AppTheme {
  //static const String fontFamily = 'Pretendard';

  // // Heading 스타일
  // static const TextStyle heading1 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.blackPrimary,
  //   fontSize: 28,
  //   height: 34 / 28, // lineHeight 적용
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle heading2 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w700,
  //   color: AppColors.blackPrimary,
  //   fontSize: 24,
  //   height: 30 / 24,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle heading3 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w700,
  //   color: AppColors.blackPrimary,
  //   fontSize: 20,
  //   height: 26 / 20,
  //   letterSpacing: 0.5,
  // );
  //
  // // title 스타일
  // static const TextStyle title1 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.blackPrimary,
  //   fontSize: 20,
  //   height: 26 / 20,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle title2 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.blackPrimary,
  //   fontSize: 18,
  //   height: 22 / 18,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle title3 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.blackPrimary,
  //   fontSize: 16,
  //   height: 20 / 16,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle title4 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.blackPrimary,
  //   fontSize: 14,
  //   height: 18 / 14,
  //   letterSpacing: 0.5,
  // );
  //
  // // body 스타일
  // static const TextStyle body1 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.blackPrimary,
  //   fontSize: 15,
  //   height: 18 / 15,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle body2 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w300,
  //   color: AppColors.blackPrimary,
  //   fontSize: 14,
  //   height: 20 / 14,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle body3 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w300,
  //   color: AppColors.blackPrimary,
  //   fontSize: 12,
  //   height: 17 / 12,
  //   letterSpacing: 0.5,
  // );
  //
  // // caption 스타일
  // static const TextStyle caption1 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w400,
  //   color: AppColors.blackPrimary,
  //   fontSize: 10,
  //   height: 16 / 10,
  //   letterSpacing: 0.5,
  // );
  //
  // static const TextStyle caption2 = TextStyle(
  //   fontFamily: fontFamily,
  //   fontWeight: FontWeight.w500,
  //   color: AppColors.blackPrimary,
  //   fontSize: 10,
  //   height: 16 / 10,
  //   letterSpacing: 0.5,
  // );

  static const String fontFamily = 'IBMPlexSansKR';

  // ===========================
  // Heading (주로 AppBar, Splash, Hero Text)
  // ===========================
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700, // Bold
    fontSize: 32,
    height: 1.3, // 굵은 폰트는 줄 간격을 좁게
    letterSpacing: -0.5, // 너무 넓어 보이지 않도록 자간 감소
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 28,
    height: 1.4,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 20,
    height: 1.4,
    letterSpacing: -0.1,
    color: AppColors.textPrimary,
  );

  // ===========================
  // Title (Body 내부의 주요 제목, Card, List Item)
  // ===========================
  static const TextStyle title1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500, // Medium
    fontSize: 20,
    height: 1.5,
    letterSpacing: 0.0, // 기본 자간 유지
    color: AppColors.textPrimary,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500, // Medium
    fontSize: 18,
    height: 1.5,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle title3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400, // Regular
    fontSize: 16,
    height: 1.6,
    letterSpacing: 0.2,
    color: AppColors.textPrimary,
  );

  // ===========================
  // Body (일반 본문, 설명 텍스트)
  // ===========================
  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400, // Regular
    fontSize: 16,
    height: 1.7, // 가독성을 위해 넉넉한 줄 높이 적용
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300, // Light
    fontSize: 14,
    height: 1.7,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w200, // ExtraLight
    fontSize: 12,
    height: 1.8,
    letterSpacing: 0.5,
    color: AppColors.textTertiary,
  );

  // ===========================
  // Caption (부가 정보, 작은 설명)
  // ===========================
  static const TextStyle caption1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300, // Light
    fontSize: 10,
    height: 1.6,
    letterSpacing: 0.5,
    color: AppColors.textTertiary,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500, // Medium
    fontSize: 10,
    height: 1.6,
    letterSpacing: 0.4,
    color: AppColors.textTertiary,
  );

  // ===========================
  // Button & Input (사용자 인터랙션)
  // ===========================
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500, // Medium
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.2,
    color: Colors.white, // 버튼은 보통 흰색 텍스트
  );

  static const TextStyle inputField = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400, // Regular
    fontSize: 14,
    height: 1.6,
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
  );
}
