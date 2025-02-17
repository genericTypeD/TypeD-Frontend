import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // ===========================
  // 기본 배경색
  // ===========================
  //static const Color whitePrimary = Color(0xFFFFFFFF);
  static const Color backgroundPrimary = Color(0xFFBAE800);
  static const Color backgroundSecondary = Color(0xFFFAF7F3);
  static const Color backgroundTertiary = Color(0xFFEEEAE7);
  static const Color backgroundQuaternary = Color(0xFF222222);

  // ===========================
  // 텍스트 색상
  // ===========================
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textTertiary = Color(0xFF9e9e9e);
  static const Color bodyTextColor = Color(0xFF868686);

  // ===========================
  // 경계선 (Border) 색상
  // ===========================
  static const Color borderPrimary = Color(0xFFD1D1D1); // 기본 테두리 (입력 필드, 카드)
  static const Color borderSecondary = Color(0xFFEAEAEA); // 연한 테두리 (비활성화 필드)
  static const Color borderTertiary = Color(0xFFd9d9d9); // 추가적인 경계선 (필요 시)
  static const Color borderFocused = Color(0xFF9E9E9E); // 입력 필드 포커스 시
  static const Color borderError = Color(0xFFFF5252); //에러 상태의 테두리 (입력 필드 등)
  static const Color borderBlack = Color(0xFF222222); // 블랙 계열 경계선
  static const Color borderGray = Color(0xFF666666); // 에러 상태의 테두리 (입력 필드 등)

  // 글자 색상
  static const Color BODY_TEXT_COLOR = Color(0xFF868686);
  // 텍스트필드 배경 색상
  static const INPUT_BG_COLOR = Color(0xFFFBFBFB);
  // 텍스트필드 테두리 색상
  static const INPUT_BORDER_COLOR = Color(0xFFF3F2F2);

  static const background = _Background();
  static const border = _Border();
}

/// Background Colors
class _Background {
  const _Background();

  final primary = const Color(0xFFF3F3F2);
}

/// Border Colors
class _Border {
  const _Border();

  final primary = Colors.black;
  final divider = const Color(0x00000000);
}
