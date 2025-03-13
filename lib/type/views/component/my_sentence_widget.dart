import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/sentence/model/sentence_model.dart';

class MySentenceWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final Sentence sentence;

  const MySentenceWidget({
    required this.onTap,
    required this.isSelected,
    required this.sentence,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.borderBlack,
              // TODO: - Sentence 모델에 Equatable 라이브러리 적용
              width: isSelected ? 0.6 : 0.3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sentence.content,
                  style: AppTheme.body2,
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      sentence.createdAt.toString(),
                      style: AppTheme.body3,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
