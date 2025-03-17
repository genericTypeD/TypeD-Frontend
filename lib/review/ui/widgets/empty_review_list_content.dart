import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';

class EmptyReviewListContent extends StatelessWidget {
  static const _reviewEmptyListText = '저장된 서평이 없습니다';

  const EmptyReviewListContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPlaceholder(size: 0.1),
          const SizedBox(height: 16),
          Text(
            _reviewEmptyListText,
            style: AppTheme.body2,
          ),
        ],
      ),
    );
  }
}
