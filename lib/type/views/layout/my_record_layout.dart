import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';

class MyRecordLayout extends StatelessWidget {
  static final _backButtonText = '뒤로 가기';
  static final _saveButtonText = '기록하기';
  static final _errorText = '오류가 발생했습니다.';

  final VoidCallback? onBottomLeftWidgetPressed;
  final VoidCallback? onBottomRightWidgetPressed;
  final Widget? bottomCenterWidget;
  final Widget? body;
  final bool useDefaultBackground;
  final bool isErrorScreen;

  const MyRecordLayout({
    this.onBottomLeftWidgetPressed,
    this.onBottomRightWidgetPressed,
    this.bottomCenterWidget,
    required this.body,
    this.useDefaultBackground = true,
    this.isErrorScreen = false,
    super.key,
  });

  const MyRecordLayout.secondary({
    this.onBottomLeftWidgetPressed,
    this.onBottomRightWidgetPressed,
    this.bottomCenterWidget,
    required this.body,
    this.useDefaultBackground = false,
    this.isErrorScreen = false,
    super.key,
  });

  const MyRecordLayout.error({
    this.onBottomLeftWidgetPressed,
    this.onBottomRightWidgetPressed,
    this.bottomCenterWidget,
    this.body,
    this.useDefaultBackground = true,
    this.isErrorScreen = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        bottomLeftWidget: _renderBottomLeftWidget(),
        bottomCenterWidget: bottomCenterWidget,
        bottomRightWidget:
            isErrorScreen ? Container() : _renderBottomRightWidget(),
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
      onPressed: onBottomLeftWidgetPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      child: Text(
        _backButtonText,
        textAlign: TextAlign.left,
        style: AppTheme.title3,
      ),
    );
  }

  Widget _renderBottomRightWidget() {
    return TextButton(
      onPressed: onBottomRightWidgetPressed,
      child: Text(
        _saveButtonText,
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
              color: useDefaultBackground
                  ? Colors.white
                  : AppColors.backgroundSecondary,
              border: Border(bottom: AppBarStyle.borderStyle),
            ),
            child: isErrorScreen ? _renderErrorContent() : body,
          ),
        ),
      ),
    );
  }

  Widget _renderErrorContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPlaceholder(size: 0.1),
        SizedBox(height: 8),
        Text(
          _errorText,
          style: AppTheme.body1,
        ),
      ],
    );
  }
}
