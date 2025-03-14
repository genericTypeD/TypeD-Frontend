import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/feed/provider/feed_filter_provider.dart';

class FeedFilterDropdown extends ConsumerWidget {
  const FeedFilterDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(feedFilterProvider);

    return PopupMenuButton<FeedFilter>(
      onSelected: (FeedFilter result) {
        ref.read(feedFilterProvider.notifier).state = result;
      },
      offset: const Offset(-13, -10),
      constraints: const BoxConstraints(minWidth: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.backgroundTertiary,
      elevation: 0,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: FeedFilter.all,
          child: Align(
            alignment: Alignment.center,
            child: Text('취향탐색', style: AppTheme.body1),
          ),
        ),
        PopupMenuItem(
          value: FeedFilter.review,
          child: Align(
            alignment: Alignment.center,
            child: Text('서평메모', style: AppTheme.body1),
          ),
        ),
        PopupMenuItem(
          value: FeedFilter.sentence,
          child: Align(
            alignment: Alignment.center,
            child: Text('문장수집', style: AppTheme.body1),
          ),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedFilter == FeedFilter.all
                ? '취향탐색'
                : selectedFilter == FeedFilter.review
                    ? '서평메모'
                    : '문장수집',
            style: AppTheme.title3,
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
