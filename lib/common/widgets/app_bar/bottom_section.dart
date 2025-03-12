import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/widgets/app_bar/section_container.dart';
import 'package:typed/common/widgets/border_container.dart';

class BottomSection extends StatelessWidget {
  final Widget? leftWidget;
  final Widget? centerWidget;
  final Widget? rightWidget;
  final bool isFeed;

  const BottomSection({
    this.leftWidget,
    this.centerWidget,
    this.rightWidget,
    this.isFeed = false,
    super.key,
  });

  factory BottomSection.feed({
    Widget? leftWidget,
    Widget? rightWidget,
  }) =>
      BottomSection(
        leftWidget: leftWidget,
        rightWidget: rightWidget,
        isFeed: true,
      );

  @override
  Widget build(BuildContext context) {
    return SectionContainer.bottom(
      child: Row(
        children: [
          const BorderContainer(type: ContainerBorderType.left),
          const SizedBox(width: AppBarStyle.sizedBoxWidth),
          Container(
            width: MediaQuery.of(context).size.width *
                AppBarStyle.bottomLeftWidgetWidthMultiplier,
            alignment: Alignment.centerLeft,
            child: leftWidget ?? Container(),
          ),
          const BorderContainer(type: ContainerBorderType.left),
          const Spacer(),
          if (!isFeed) ...[
            centerWidget ?? Container(),
            const SizedBox(width: AppBarStyle.sizedBoxWidth),
          ],
          rightWidget ?? Container(),
          const BorderContainer(type: ContainerBorderType.right),
        ],
      ),
    );
  }
}
