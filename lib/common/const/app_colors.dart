import 'package:flutter/material.dart';

// class AppColors {
//   const AppColors._();
//
//   // GrayScale
//   static const Color whitePrimary = Color(0xFFFFFFFF);
//   static const Color backgroundPrimary = Color(0xFFf8f8f8);
//   static const Color backgroundSecondary = Color(0xFFeeeeee);
//   static const Color backgroundTertiary = Color(0xFFe4e4e4);
//   static const Color LineTertiary = Color(0xFFd9d9d9);
//   static const Color TextTertiary = Color(0xFF9e9e9e);
//   static const Color TextSecondary = Color(0xFF616161);
//   static const Color blackPrimary = Color(0xFF222222);
//
//   // 글자 색상
//   static const Color BODY_TEXT_COLOR = Color(0xFF868686);
//   // 텍스트필드 배경 색상
//   static const INPUT_BG_COLOR = Color(0xFFFBFBFB);
//   // 텍스트필드 테두리 색상
//   static const INPUT_BORDER_COLOR = Color(0xFFF3F2F2);
// }

abstract class AppColors {
  AppColors._();

  // ===========================
  // 기본 배경색
  // ===========================
  //static const Color whitePrimary = Color(0xFFFFFFFF);
  static const Color backgroundPrimary = Color(0xFFBAE800);
  static const Color backgroundSecondary = Color(0xFFFAF7F3);
  static const Color backgroundTertiary = Color(0xFFEEEAE7);
  static const Color backgroundQuaternary = Color(0xFF222222);

  // ===========================
  // 버튼 색상
  // ===========================
  static const Color primaryButton = Color(0xFF007AFF); // 주요 버튼 (확인, 저장 등)
  static const Color secondaryButton = Color(0xFF8E8E93); // 보조 버튼 (취소, 뒤로 가기)
  static const Color tertiaryButton = Color(0xFFEEEEEE); // 서브 버튼 (덜 강조된 버튼)
  static const Color dangerButton = Color(0xFFFF3B30); // 경고 버튼 (삭제, 탈퇴 등)
  static const Color disabledButton = Color(0xFFD1D1D6); // 비활성화 버튼 (사용 불가)

  // ===========================
  // 구분선 (Divider) 색상
  // ===========================
  static const Color dividerPrimary = Color(0xFFE0E0E0); // 기본 구분선 (리스트뷰, 섹션 구분)
  static const Color dividerThin = Color(0xFFF3F3F3); // 얇은 구분선 (설정 화면 등)
  static const Color dividerDark = Color(0xFFBDBDBD); // 짙은 구분선 (대비 강조 필요 시)
  static const Color dividerBlack = Color(0xFF333333);
  static const Color dividerGray = Color(0xFF888888);

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

  // ===========================
  // 텍스트 색상
  // ===========================
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textTertiary = Color(0xFF9e9e9e);
  static const Color bodyTextColor = Color(0xFF868686);

  // ===========================
  // 입력 필드 관련 색상
  // ===========================
  static const Color inputBgColor = Color(0xFFFBFBFB);
  static const Color inputBorderColor = Color(0xFFF3F2F2);
}
