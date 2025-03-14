import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';
import 'package:typed/feed/component/feed_filter_dropdown.dart';
import 'package:typed/feed/component/feed_list.dart';
import 'package:typed/feed/provider/feed_provider.dart';
import 'package:typed/feed/provider/feed_search_provider.dart';

// TextEditingController를 Riverpod 상태로 관리
final searchControllerProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
);

// 필터 상태 관리 (랜덤, 서평메모, 문장수집)
final feedFilterProvider = StateProvider<String>((ref) => 'random');

class FeedPublic extends ConsumerWidget {
  const FeedPublic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feeds = ref.watch(feedProvider);
    final searchQuery = ref.watch(feedSearchProvider);
    final searchController = ref.watch(searchControllerProvider);
    final selectedFilter = ref.watch(feedFilterProvider);

    final filteredFeeds = feeds.where((feed) {
      if (selectedFilter == 'random') {
        return true; // 랜덤 피드는 전체 출력
      } else if (selectedFilter == 'review') {
        return feed.type == 'review'; // 서평메모만 필터링
      } else if (selectedFilter == 'sentence') {
        return feed.type == 'sentence'; // 문장수집만 필터링
      }
      return false;
    }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultLayout(
        appBar: CustomAppBar(
          bottomLeftWidget: FeedFilterDropdown(),
          bottomRightWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
              width: 200,
              height: 38,
              child: TextField(
                controller: searchController,
                cursorHeight: 16,
                onChanged: (value) =>
                    ref.read(feedSearchProvider.notifier).state = value,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: AppTheme.body2,
                  filled: true,
                  fillColor: AppColors.backgroundTertiary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 20,
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.black54,
                            size: 20,
                          ),
                          onPressed: () {
                            searchController.clear();
                            ref.read(feedSearchProvider.notifier).state = '';
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        child: Container(
          color: AppColors.backgroundSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: filteredFeeds.isEmpty
              ? Center(
                  child: Text(
                    "새로운 취향을 탐색해보세요!",
                    style: AppTheme.body1,
                  ),
                )
              : FeedList(feeds: filteredFeeds),
        ),
      ),
    );
  }
}
