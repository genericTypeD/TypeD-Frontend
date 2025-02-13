import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/custom_app_bar.dart';

class MyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: const Text(
            "텍스트A",
            style: TextStyle(fontSize: 14),
          ),
        ),
        bottomRightWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: const Text(
            "글쓰기",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text("아직 수집된 문장이 없습니다."),
            ),
          ),
        ],
      ),
    );
  }
}
