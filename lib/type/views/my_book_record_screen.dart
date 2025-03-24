import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';
import 'package:typed/review/ui/components/custom_progress_indicator.dart';
import 'package:typed/review/viewmodels/review_providers.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/views/layout/my_record_layout.dart';
import 'package:typed/type/views/widgets/my_review_widget.dart';
import 'package:uuid/uuid.dart';

class MyBookRecordScreen extends ConsumerStatefulWidget {
  final GridItem? item;

  const MyBookRecordScreen({
    this.item,
    super.key,
  });

  @override
  ConsumerState<MyBookRecordScreen> createState() => _MyBookRecordScreenState();
}

class _MyBookRecordScreenState extends ConsumerState<MyBookRecordScreen> {
  // TODO: - 야매로 인덱스로 선택 여부 확인하는 방식 당연히 바꿔야.....
  int selectedBookIndex = -1;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(ReviewProviders.reviewListProvider.notifier);
    });
  }

  // TODO: - 트러블슈팅
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.item != null && widget.item!.isBook && widget.item!.isValid) {
      final reviewsState = ref.read(ReviewProviders.reviewListProvider);

      reviewsState.whenOrNull(
        data: (reviews) {
          setState(() {
            selectedBookIndex = reviews.indexWhere((review) {
              return review.bookIsbn == widget.item!.bookReview!.bookIsbn;
            });
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(ReviewProviders.reviewListProvider);

    return reviewsState.when(
      data: (reviews) {
        return MyRecordLayout(
          onBottomLeftWidgetPressed: () => Navigator.pop(context),
          onBottomRightWidgetPressed: () async {
            if (selectedBookIndex != -1) {
              final result = GridItem.bookReview(
                id: Uuid().v4(),
                bookReview: reviews[selectedBookIndex],
              );
              Navigator.pop(context, result);
            }
          },
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
              itemCount: reviews.length,
              itemBuilder: (BuildContext context, int index) {
                final item = reviews[index];

                return MyReviewWidget(
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
                  placeholder: CustomPlaceholder(size: 0.1),
                );
              },
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        debugPrint('$error');

        return MyRecordLayout.error(
          onBottomLeftWidgetPressed: () => context.pop(),
        );
      },
      loading: () => CustomProgressIndicator(),
    );
  }
}
