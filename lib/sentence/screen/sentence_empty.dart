import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/custom_app_bar.dart';

class SentenceEmpty extends StatelessWidget {
  const SentenceEmpty({super.key});

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
            style: AppTheme.title3,
          ),
        ),
        bottomRightWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Text(
                "글쓰기",
                style: AppTheme.title3,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/sentence_input'),
        backgroundColor: const Color(0xFFF3F3F2),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: const Text("+", style: TextStyle(fontSize: 24)),
      ),
      child: Container(
        color: AppColors.backgroundSecondary,
        child: const Column(
          children: [
            Expanded(
              child: Center(
                child: Text("아직 수집된 문장이 없습니다."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
