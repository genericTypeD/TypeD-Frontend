import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/widgets/app_bar/section_container.dart';
import 'package:typed/common/widgets/border_container.dart';

class HeaderSection extends StatelessWidget {
  final Widget? iconButton;

  const HeaderSection({
    super.key,
    this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Row(
        children: [
          const BorderContainer(type: ContainerBorderType.left),
          const SizedBox(width: AppBarStyle.sizedBoxWidth),
          const Text(
            AppBarStyle.titleAppName,
            style: AppBarStyle.titleTextStyle,
          ),
          const Spacer(),
          iconButton ?? Container(),
          const SizedBox(width: AppBarStyle.sizedBoxWidth),
          const BorderContainer(type: ContainerBorderType.right),
        ],
      ),
    );
  }
}
