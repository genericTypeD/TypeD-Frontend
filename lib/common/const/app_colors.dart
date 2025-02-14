import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // GrayScale
  static const Color whitePrimary = Color(0xFFFFFFFF);
  static const Color backgroundPrimary = Color(0xFFf8f8f8);
  static const Color backgroundSecondary = Color(0xFFeeeeee);
  static const Color backgroundTertiary = Color(0xFFe4e4e4);
  static const Color LineTertiary = Color(0xFFd9d9d9);
  static const Color TextTertiary = Color(0xFF9e9e9e);
  static const Color TextSecondary = Color(0xFF616161);
  static const Color blackPrimary = Color(0xFF222222);

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
