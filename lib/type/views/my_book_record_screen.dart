import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/models/review_model.dart';
import 'package:typed/type/models/dummies/dummy_bookreviews.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/views/layout/my_record_layout.dart';
import 'package:uuid/uuid.dart';

class MyBookRecordScreen extends StatefulWidget {
  final GridItem? item;

  const MyBookRecordScreen({
    this.item,
    super.key,
  });

  @override
  State<MyBookRecordScreen> createState() => _MyBookRecordScreenState();
}

class _MyBookRecordScreenState extends State<MyBookRecordScreen> {
  // TODO: - 야매로 인덱스로 선택 여부 확인하는 방식 당연히 바꿔야.....
  late int selectedBookIndex;

  @override
  void initState() {
    super.initState();

    if (widget.item != null && widget.item!.isBook && widget.item!.isValid) {
      selectedBookIndex = dummyBookReviews.indexWhere((review) {
        if (review.bookIsbn == widget.item!.bookReview!.bookIsbn) {
          return true;
        } else {
          return false;
        }
      });
    } else {
      selectedBookIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyRecordLayout(
      onBottomLeftWidgetPressed: () => Navigator.pop(context),
      onBottomRightWidgetPressed: () async {
        if (selectedBookIndex != -1) {
          final result = GridItem.bookReview(
            id: Uuid().v4(),
            bookReview: dummyBookReviews[selectedBookIndex],
          );
          Navigator.pop(context, result);
        }
      },
      // body: [
      //   Expanded(
      //     child: ,
      //   ),
      // ],
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: dummyBookReviews.length,
          itemBuilder: (BuildContext context, int index) {
            final item = dummyBookReviews[index];

            return BookReviewWidget(
              item: item,
              onTap: () {
                setState(() {
                  if (selectedBookIndex == -1) {
                    selectedBookIndex = index;
                  } else {
                    selectedBookIndex = -1;
                  }
                });
              },
              isSelected: selectedBookIndex == index,
              placeholder: _buildPlaceholder(),
            );
          },
        ),
      ),
    );
  }

  // TODO: - common으로 빼기
  Widget _buildPlaceholder() {
    return Center(
      child: Image.asset(
        'assets/images/grid_item_placeholder.png',
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        children: [
          _buildPlaceholder(),
          Text(
            '오류가 발생했습니다.',
            style: AppTheme.body1,
          ),
        ],
      ),
    );
  }
}

class BookReviewWidget extends StatelessWidget {
  final Review item;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget placeholder;

  const BookReviewWidget({
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
                    // if (selectedBookIndex == index) {
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
