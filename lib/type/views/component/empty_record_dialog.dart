import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class EmptyRecordDialog extends StatelessWidget {
  final String title;
  final String acceptButtonText;
  final VoidCallback? onAccept;

  const EmptyRecordDialog({
    this.title = AppStrings.emptyRecordDialogTitle,
    this.acceptButtonText = AppStrings.acceptButton,
    this.onAccept,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _buildDialogContent(context),
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      elevation: 0,
      shape: AppBorders.all,
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacings.spacing24),
        Center(
          child: Text(
            title,
            style: AppTheme.body2.copyWith(
              fontWeight: FontWeight.bold,
              height: 1,
            ),
            textAlign: TextAlign.center,
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
              acceptButtonText,
              style: AppTheme.body2.copyWith(
                height: 1,
              ),
            ),
            onPressed: () {
              onAccept?.call();
              Navigator.of(context).pop();
            },
          ),
        ),
        const SizedBox(height: AppSpacings.spacing16),
      ],
    );
  }
}
