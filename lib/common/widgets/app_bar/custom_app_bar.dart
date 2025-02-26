import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/widgets/app_bar/bottom_section.dart';
import 'package:typed/common/widgets/app_bar/header_section.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? bottomLeftWidget;
  final Widget? bottomCenterWidget;
  final Widget? bottomRightWidget;

  @override
  final Size preferredSize;

  const CustomAppBar({
    super.key,
    this.bottomLeftWidget,
    this.bottomCenterWidget,
    this.bottomRightWidget,
  }) : preferredSize = const Size.fromHeight(AppBarStyle.appbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
      ),
      child: SafeArea(
        child: Column(
          children: [
            HeaderSection(
              titleWidget: GestureDetector(
                onTap: () {
                  context.push('/home/type');
                },
                child: Text(
                  AppBarStyle.titleAppName,
                  style: AppBarStyle.titleTextStyle,
                ),
              ),
              iconButton: GestureDetector(
                onTap: () {
                  context.push('/notifications');
                },
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
            ),
            BottomSection(
              leftWidget: bottomLeftWidget,
              centerWidget: bottomCenterWidget,
              rightWidget: bottomRightWidget,
            ),
          ],
        ),
      ),
    );
  }
}
