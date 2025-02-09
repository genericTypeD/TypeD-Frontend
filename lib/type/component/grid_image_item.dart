import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';

// TODO: - refactor: 이미지 경로를 외부로부터 주입 받는 별도 위젯으로 분리
// TODO: - refactor: 상수 분리(borderWidth, padding, margin 등)
// TODO: - feat: 에러 처리 추가

class GridImageItem extends StatelessWidget {
  const GridImageItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blackPrimary,
          width: 0.4,
        ),
      ),
      height: double.infinity,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Image.asset(
          'assets/images/sample_book_image.png',
          fit: BoxFit.contain,
          cacheWidth: MediaQuery.of(context).size.width.toInt(),
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.backgroundTertiary,
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
