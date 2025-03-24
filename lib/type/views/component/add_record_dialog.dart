import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/ui/components/index.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/views/component/record_category_item.dart';
import 'package:typed/type/models/grid_item.dart';

class AddRecordDialog extends StatelessWidget {
  final GridItem item;
  final VoidCallback? onResetButtonTapped;

  const AddRecordDialog({
    required this.item,
    this.onResetButtonTapped,
    super.key,
  });

  static Widget create(GridItem item) {
    switch (item.type) {
      case GridItemType.empty:
        return EmptyAddRecordDialog(item: item);
      case GridItemType.image:
        return ImageAddRecordDialog(item: item);
      case GridItemType.music:
        return MusicAddRecordDialog(item: item);
      case GridItemType.bookReview:
        return ReviewAddRecordDialog(item: item);
      case GridItemType.sentence:
        return SentenceAddRecordDialog(item: item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          color: AppColors.backgroundTertiary,
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.black,
              width: 0.3,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/book_detail');
                      }
                    },
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: onResetButtonTapped,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundTertiary,
                        border: Border.all(
                          color: AppColors.borderBlack,
                          width: 0.3,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh,
                                size: 16,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '리셋',
                                style: AppTheme.body2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  border: Border.all(
                    color: AppColors.borderBlack,
                    width: 0.3,
                  ),
                ),
                child: Center(
                  child: CustomPlaceholder(size: 0.06),
                ),
              ),
              SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  mainAxisExtent: MediaQuery.of(context).size.height * 0.06,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: RecordCategoryItem.allCategories.length,
                itemBuilder: (context, index) {
                  final categoryItem = RecordCategoryItem.allCategories[index];

                  return GestureDetector(
                    onTap: () async {
                      final result = await context.pushNamed<GridItem>(
                        categoryItem.routeName,
                        extra: {'item': item},
                      );

                      if (result == null && context.mounted) {
                        context.pop();
                      }

                      if (result != null && context.mounted) {
                        context.pop(result);
                      }
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundTertiary,
                        border: Border.all(
                          color: AppColors.borderBlack,
                          width: 0.3,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              categoryItem.icon,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              categoryItem.label,
                              style: AppTheme.body2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyAddRecordDialog extends AddRecordDialog {
  const EmptyAddRecordDialog({
    required super.item,
    super.key,
  });
}

class ImageAddRecordDialog extends AddRecordDialog {
  const ImageAddRecordDialog({
    required super.item,
    super.key,
  });
}

class MusicAddRecordDialog extends AddRecordDialog {
  const MusicAddRecordDialog({
    required super.item,
    super.key,
  });
}

class ReviewAddRecordDialog extends AddRecordDialog {
  const ReviewAddRecordDialog({
    required super.item,
    super.key,
  });
}

class SentenceAddRecordDialog extends AddRecordDialog {
  const SentenceAddRecordDialog({
    required super.item,
    super.key,
  });
}
