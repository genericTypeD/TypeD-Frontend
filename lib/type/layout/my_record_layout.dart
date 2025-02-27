import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';

class MyRecordLayout extends StatefulWidget {
  final VoidCallback? onBottomRightWidgetPressed;
  final Widget? bottomCenterWidget;
  final List<Widget> body;

  const MyRecordLayout({
    this.onBottomRightWidgetPressed,
    this.bottomCenterWidget,
    required this.body,
    super.key,
  });

  @override
  State<MyRecordLayout> createState() => _MyRecordLayoutState();
}

class _MyRecordLayoutState extends State<MyRecordLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: const Color(0xffF3F3F2),
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
      onPressed: () => Navigator.pop(context),
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
        color: Color(0xffF3F3F2),
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
        color: Color(0xffF3F3F2),
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
        color: const Color(0xffF3F3F2),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: AppBarStyle.borderStyle),
            ),
            child: Column(
              children: widget.body,
            ),
          ),
        ),
      ),
    );
  }
}
