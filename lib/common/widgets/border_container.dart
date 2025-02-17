import 'package:flutter/material.dart';
import 'package:typed/common/const/app_bar_style.dart';

enum ContainerBorderType {
  left,
  right;

  BorderSide get borderSide {
    return AppBarStyle.borderStyle;
  }
}

class BorderContainer extends StatelessWidget {
  final ContainerBorderType type;
  final Color? backgroundColor;

  const BorderContainer({
    required this.type,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppBarStyle.borderContainerWidth,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          left: type == ContainerBorderType.right
              ? type.borderSide
              : BorderSide.none,
          right: type == ContainerBorderType.left
              ? type.borderSide
              : BorderSide.none,
        ),
      ),
    );
  }
}
