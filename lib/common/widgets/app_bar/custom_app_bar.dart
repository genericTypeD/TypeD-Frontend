import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/widgets/app_bar/bottom_section.dart';
import 'package:typed/common/widgets/app_bar/header_section.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? bottomLeftWidget;
  final Widget? bottomCenterWidget;
  final Widget? bottomRightWidget;
  final Widget? iconButton;
  final bool isMyPage;
  final bool isShowingNotifications;

  @override
  final Size preferredSize;

  const CustomAppBar({
    super.key,
    this.bottomLeftWidget,
    this.bottomCenterWidget,
    this.bottomRightWidget,
    this.iconButton,
    this.isMyPage = false,
    this.isShowingNotifications = false,
  }) : preferredSize = const Size.fromHeight(AppBarStyle.appbarHeight);

  factory CustomAppBar.myPage({
    Widget? bottomLeftWidget,
    Widget? bottomCenterWidget,
    Widget? bottomRightWidget,
  }) =>
      CustomAppBar(
        bottomLeftWidget: bottomLeftWidget,
        bottomCenterWidget: bottomCenterWidget,
        bottomRightWidget: bottomRightWidget,
        isMyPage: true,
      );

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
              iconButton: isShowingNotifications
                  ? GestureDetector(
                      onTap: () {
                        context.push('/notifications');
                      },
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                    )
                  : null,
            ),
            if (!isMyPage)
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
