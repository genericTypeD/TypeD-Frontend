import 'package:flutter/material.dart';
import 'package:typed/common/const/app_sizes.dart';

class AppBorders {
  const AppBorders._();

  static const BorderSide defaultBorder = BorderSide(
    color: Colors.black,
    width: AppSizes.borderWidth,
  );

  static const Border left = Border(
    left: defaultBorder,
  );

  static const Border right = Border(
    right: defaultBorder,
  );

  static const Border top = Border(
    top: defaultBorder,
  );

  static const Border bottom = Border(
    bottom: defaultBorder,
  );

  static const Border all = Border(
    left: defaultBorder,
    right: defaultBorder,
    top: defaultBorder,
    bottom: defaultBorder,
  );

  static const Border topLeft = Border(
    top: defaultBorder,
    left: defaultBorder,
  );

  static const Border topRight = Border(
    top: defaultBorder,
    right: defaultBorder,
  );

  static const Border bottomLeft = Border(
    bottom: defaultBorder,
    left: defaultBorder,
  );

  static const Border bottomRight = Border(
    bottom: defaultBorder,
    right: defaultBorder,
  );

  static const Border leftRight = Border(
    left: defaultBorder,
    right: defaultBorder,
  );

  static const Border topBottom = Border(
    top: defaultBorder,
    bottom: defaultBorder,
  );
}
