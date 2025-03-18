import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class BorderedEmptyContainer extends StatelessWidget {
  final bool showLeftBorder;
  final bool showRightBorder;

  const BorderedEmptyContainer({
    this.showLeftBorder = false,
    this.showRightBorder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppBarStyle.borderContainerWidth,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        border: Border(
          left: showRightBorder ? AppBarStyle.borderStyle : BorderSide.none,
          right: showLeftBorder ? AppBarStyle.borderStyle : BorderSide.none,
        ),
      ),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: AppBarStyle.borderStyle,
            ),
          ),
        ),
      ),
    );
  }

  factory BorderedEmptyContainer.left() => BorderedEmptyContainer(
        showLeftBorder: true,
      );

  factory BorderedEmptyContainer.right() => BorderedEmptyContainer(
        showRightBorder: true,
      );
}
