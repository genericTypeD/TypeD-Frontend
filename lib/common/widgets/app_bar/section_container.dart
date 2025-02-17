import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;

  const SectionContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBarStyle.sectionHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: AppBarStyle.borderStyle,
        ),
      ),
      child: child,
    );
  }
}
