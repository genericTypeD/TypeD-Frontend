import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typed/common/const/app_colors.dart';

class AppTheme {
  // ===========================
  // Heading (AppBar, Splash, Hero Text)
  // ===========================
  static final TextStyle heading1 = GoogleFonts.dmSerifDisplay(
    fontWeight: FontWeight.w700, // Bold
    fontSize: 32,
    height: 1.3, // 굵은 글씨 줄 높이 감소
    letterSpacing: -0.5, // 자간 감소 (너무 넓어 보이지 않도록)
    color: AppColors.textPrimary,
  );

  static final TextStyle heading2 = GoogleFonts.dmSerifDisplay(
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 28,
    height: 1.4,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
  );

  static final TextStyle heading3 = GoogleFonts.dmSerifDisplay(
    fontWeight: FontWeight.w400, // Regular
    fontSize: 20,
    height: 1.4,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );

  // ===========================
  // Title (Body 내부의 주요 제목, Card, List Item)
  // ===========================
  static final TextStyle title1 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 20,
    height: 1.5,
    letterSpacing: 0.2,
    color: AppColors.textPrimary,
  );

  static final TextStyle title2 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.5,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static final TextStyle title3 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w400, // Regular
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.2,
    color: AppColors.textPrimary,
  );

  // ===========================
  // Body (일반 본문, 설명 텍스트)
  // ===========================
  static final TextStyle body1 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.7, // 본문은 줄 높이를 넉넉하게
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
  );

  static final TextStyle body2 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w300, // Light
    fontSize: 14,
    height: 1.7,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  static final TextStyle body3 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w200, // ExtraLight
    fontSize: 12,
    height: 1.8,
    letterSpacing: 0.3,
    color: AppColors.textTertiary,
  );

  // ===========================
  // Caption (부가 정보, 작은 설명)
  // ===========================
  static final TextStyle caption1 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w300, // Light
    fontSize: 10,
    height: 1.6,
    letterSpacing: 0.5,
    color: AppColors.textTertiary,
  );

  static final TextStyle caption2 = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 10,
    height: 1.6,
    letterSpacing: 0.4,
    color: AppColors.textTertiary,
  );

  // ===========================
  // Button & Input (사용자 인터랙션)
  // ===========================
  static final TextStyle button = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w500, // Medium
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  static final TextStyle inputField = GoogleFonts.ibmPlexSansKr(
    fontWeight: FontWeight.w400, // Regular
    fontSize: 14,
    height: 1.6,
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
  );
}
