import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';

class MyRecordLayout extends StatefulWidget {
  final VoidCallback? onBottomLeftWidgetPressed;
  final VoidCallback? onBottomRightWidgetPressed;
  final Widget? bottomCenterWidget;
  // final List<Widget> body;
  final Widget body;
  final bool useDefaultBackground;

  const MyRecordLayout({
    this.onBottomLeftWidgetPressed,
    this.onBottomRightWidgetPressed,
    this.bottomCenterWidget,
    required this.body,
    this.useDefaultBackground = true,
    super.key,
  });

  const MyRecordLayout.secondary({
    this.onBottomLeftWidgetPressed,
    this.onBottomRightWidgetPressed,
    this.bottomCenterWidget,
    required this.body,
    this.useDefaultBackground = false,
    super.key,
  });

  @override
  State<MyRecordLayout> createState() => _MyRecordLayoutState();
}

class _MyRecordLayoutState extends State<MyRecordLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        bottomLeftWidget: _renderBottomLeftWidget(),
        bottomCenterWidget: widget.bottomCenterWidget,
        bottomRightWidget: _renderBottomRightWidget(),
      ),
      child: Row(
        children: [
          _renderLeftSection(),
          _renderBody(),
          _renderRightSection(),
        ],
      ),
    );
  }

  Widget _renderBottomLeftWidget() {
    return TextButton(
      onPressed: widget.onBottomLeftWidgetPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      child: Text(
        '뒤로 가기',
        textAlign: TextAlign.left,
        style: AppTheme.title3,
      ),
    );
  }

  Widget _renderBottomRightWidget() {
    return TextButton(
      onPressed: widget.onBottomRightWidgetPressed,
      child: Text(
        '기록하기',
        style: AppTheme.title3.copyWith(
          height: 1,
        ),
      ),
    );
  }

  Widget _renderLeftSection() {
    return Container(
      width: AppBarStyle.borderContainerWidth,
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        border: Border(right: AppBarStyle.borderStyle),
      ),
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: AppBarStyle.borderStyle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderRightSection() {
    return Container(
      width: AppBarStyle.borderContainerWidth,
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        border: Border(left: AppBarStyle.borderStyle),
      ),
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: AppBarStyle.borderStyle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderBody() {
    return Expanded(
      child: Container(
        color: AppColors.backgroundSecondary,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: widget.useDefaultBackground
                  ? Colors.white
                  : AppColors.backgroundSecondary,
              border: Border(bottom: AppBarStyle.borderStyle),
            ),
            // child: Column(
            //   children: widget.body,
            // ),
            child: widget.body,
          ),
        ),
      ),
    );
  }
}
