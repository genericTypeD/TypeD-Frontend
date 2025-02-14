import 'package:flutter/material.dart';
import 'package:typed/common/const/app_bar_style.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/widgets/border_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? topIconButton;
  final Widget? bottomLeftWidget;
  final Widget? bottomCenterWidget;
  final Widget? bottomRightWidget;

  @override
  final Size preferredSize;

  const CustomAppBar({
    super.key,
    this.topIconButton,
    this.bottomLeftWidget,
    this.bottomCenterWidget,
    this.bottomRightWidget,
  }) : preferredSize = const Size.fromHeight(AppBarStyle.appbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppBarStyle.backgroundColor,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: AppBarStyle.sectionHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: AppBarStyle.borderStyle,
          bottom: AppBarStyle.borderStyle,
        ),
      ),
      child: Row(
        children: [
          const BorderContainer(type: ContainerBorderType.left),
          const SizedBox(width: AppBarStyle.sizedBoxWidth),
          const Text(
            'TypeD',
            style: AppTheme.heading3,

            // style: TextStyle(
            //   fontSize: 18,
            //   fontWeight: FontWeight.bold,
            //   color: Colors.black,
          ),

          const Spacer(),
          //topIconButton ?? Container(),
          topIconButton ??
              GestureDetector(
                onTap: () {
                  debugPrint('알림 클릭됨');
                },
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
          const SizedBox(width: AppBarStyle.sizedBoxWidth),
          const BorderContainer(type: ContainerBorderType.right),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      height: AppBarStyle.sectionHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: AppBarStyle.borderStyle,
        ),
      ),
      child: Row(
        children: [
          const BorderContainer(type: ContainerBorderType.left),
          const SizedBox(width: AppBarStyle.sizedBoxWidth),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: bottomLeftWidget ?? Container(),
          ),
          const BorderContainer(type: ContainerBorderType.left),
          const Spacer(),
          bottomCenterWidget ?? Container(),

          // Right
          const SizedBox(width: AppBarStyle.sizedBoxWidth),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            child: bottomRightWidget ?? Container(),
          ),

          const BorderContainer(type: ContainerBorderType.right),
        ],
      ),
    );
  }
}
