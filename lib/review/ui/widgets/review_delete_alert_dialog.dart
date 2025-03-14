import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';

class ReviewDeleteAlertDialog extends StatelessWidget {
  final VoidCallback onDeleteButtonPressed;

  const ReviewDeleteAlertDialog({
    required this.onDeleteButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: LinearBorder(
          side: BorderSide(
        width: 0.3,
        color: AppColors.borderBlack,
      )),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            '서평 삭제',
            style: AppTheme.title2,
          ),
          const SizedBox(height: 8),
          Text(
            '이 서평을 삭제하시겠습니까?',
            style: AppTheme.body1,
          ),
          const SizedBox(height: 8),
          Divider(
            thickness: 0.3,
            color: AppColors.borderBlack,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop(false);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop(false);
                    }
                  },
                  child: Text(
                    '취소',
                    style: AppTheme.body2,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => onDeleteButtonPressed,
                  child: Text(
                    '삭제',
                    style: AppTheme.body2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
