import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class EmptyRecordDialog extends StatelessWidget {
  const EmptyRecordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        const SizedBox(height: AppSpacings.spacing24),
        Center(
          child: Text(
            '기록이 비었습니다.',
            style: AppTheme.body2.copyWith(
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: AppSpacings.spacing24),
        const Divider(
          color: Colors.black,
          thickness: 0.3,
          height: 0.3,
        ),
        const SizedBox(height: AppSpacings.spacing16),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '확인',
              style: AppTheme.body2.copyWith(
                height: 1,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const SizedBox(height: AppSpacings.spacing16),
      ],
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      elevation: 0,
      shape: AppBorders.all,
    );
  }
}
