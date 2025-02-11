import 'package:flutter/material.dart';

enum ContainerBorderType {
  left,
  right;

  BorderSide get borderSide {
    return const BorderSide(
      color: Colors.black,
      width: 0.3,
    );
  }
}

class BorderContainer extends StatelessWidget {
  final ContainerBorderType type;

  const BorderContainer({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.0,
      decoration: BoxDecoration(
        border: Border(
          left: type == ContainerBorderType.right
              ? type.borderSide
              : BorderSide.none,
          right: type == ContainerBorderType.left
              ? type.borderSide
              : BorderSide.none,
        ),
      ),
    );
  }
}
