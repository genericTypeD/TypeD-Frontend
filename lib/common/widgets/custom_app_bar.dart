import 'package:flutter/material.dart';
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
  }) : preferredSize = const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffF3F3F2),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 상단 영역
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 0.3,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const BorderContainer(type: ContainerBorderType.left),
                  const SizedBox(width: 16),
                  const Text(
                    'TypeD',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  topIconButton ?? Container(),
                  const SizedBox(width: 16),
                  const BorderContainer(type: ContainerBorderType.right),
                ],
              ),
            ),
            // 하단 영역
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 0.3,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const BorderContainer(type: ContainerBorderType.left),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: bottomLeftWidget ?? Container(),
                  ),
                  const BorderContainer(type: ContainerBorderType.left),
                  const Spacer(),
                  bottomCenterWidget ?? Container(),
                  const SizedBox(width: 16),
                  bottomRightWidget ?? Container(),
                  const BorderContainer(type: ContainerBorderType.right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
