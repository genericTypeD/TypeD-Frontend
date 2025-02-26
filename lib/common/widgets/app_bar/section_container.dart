import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final bool? isHeaderSection;

  const SectionContainer({
    required this.child,
    this.isHeaderSection,
    super.key,
  });

  factory SectionContainer.headerSection({
    required Widget child,
  }) =>
      SectionContainer(
        isHeaderSection: true,
        child: child,
      );

  factory SectionContainer.bottomSection({
    required Widget child,
  }) =>
      SectionContainer(
        isHeaderSection: false,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBarStyle.sectionHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: isHeaderSection == true
              ? AppBarStyle.borderStyle
              : BorderSide.none,
          bottom: AppBarStyle.borderStyle,
        ),
      ),
      child: child,
    );
  }
}
