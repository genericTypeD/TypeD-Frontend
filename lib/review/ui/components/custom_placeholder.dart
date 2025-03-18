import 'package:flutter/material.dart';

class CustomPlaceholder extends StatelessWidget {
  final double size;

  const CustomPlaceholder({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/grid_item_placeholder.png',
      width: MediaQuery.of(context).size.width * size,
      height: MediaQuery.of(context).size.width * size,
    );
  }
}
