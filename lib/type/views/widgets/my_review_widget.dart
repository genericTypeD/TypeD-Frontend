import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/data/models/review_model.dart';

class MyReviewWidget extends StatelessWidget {
  final Review item;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget placeholder;

  const MyReviewWidget({
    required this.item,
    required this.onTap,
    required this.isSelected,
    required this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderBlack,
            width: isSelected ? 0.6 : 0.3,
          ),
          color: AppColors.backgroundTertiary,
        ),
        child: item.thumbnail != null
            ? Image.network(
                item.thumbnail!,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    if (isSelected) {
                      // TODO: - 썸네일 없는 경우
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          child,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black26,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: AspectRatio(
                              aspectRatio: 1.2,
                              child: Container(
                                width: double.infinity,
                                color: Colors.white54,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.bookTitle,
                                        style: AppTheme.body1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Flexible(
                                        child: Text(
                                          item.content,
                                          style: AppTheme.body3.copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return child;
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.borderBlack,
                      strokeWidth: 3,
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.06,
                        minHeight: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => placeholder,
              )
            : placeholder,
      ),
    );
  }
}
