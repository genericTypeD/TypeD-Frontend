import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/custom_app_bar.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

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
      child: const Column(
        children: [
          Expanded(
            child: Center(
              child: Text("취향 탐색 피드입니다."),
            ),
          ),
        ],
      ),
    );
  }
}
