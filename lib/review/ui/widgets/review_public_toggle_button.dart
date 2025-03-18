import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/lock_enum.dart';

class ReviewPublicToggleButton extends StatelessWidget {
  final bool isPrivate;
  final VoidCallback onPressed;

  const ReviewPublicToggleButton({
    required this.isPrivate,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          overlayColor: Colors.transparent,
        ),
        onPressed: onPressed,
        icon: Icon(
          isPrivate ? Icons.lock_outline : Icons.lock_open,
          size: 20.0,
          color: Colors.black,
        ),
        label: Text(
          isPrivate ? LockStatus.closed.korName : LockStatus.open.korName,
          style: AppTheme.body2.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
