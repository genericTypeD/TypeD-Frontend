import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';
import 'package:typed/feed/component/feed_list.dart';
import 'package:typed/feed/provider/feed_provider.dart';
import 'package:typed/feed/provider/feed_search_provider.dart';

// TextEditingController를 Riverpod 상태로 관리
final searchControllerProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
);

class FeedPublic extends ConsumerWidget {
  const FeedPublic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feeds = ref.watch(feedProvider);
    final searchQuery = ref.watch(feedSearchProvider);
    final searchController = ref.watch(searchControllerProvider);

    final filteredFeeds = feeds
        .where((feed) =>
            feed.content.contains(searchQuery) || // 검색어가 내용에 포함되었는지 확인
            feed.hashtags?.any((tag) => tag.contains(searchQuery)) ==
                true) // 해시태그 검색
        .toList(); // 검색 결과 필터링

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultLayout(
        appBar: CustomAppBar(
          bottomLeftWidget: Text(
            '공개된',
            style: AppTheme.title3,
          ),
          bottomRightWidget: Padding(
            padding: const EdgeInsets.only(right: 12.0),
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
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 20,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 20,
                  ), // 왼쪽에 돋보기 아이콘 배치
                  suffixIcon:
                      searchController.text.isNotEmpty // 입력값이 있을 때만 X 버튼 표시
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.black54,
                                size: 20,
                              ),
                              onPressed: () {
                                searchController.clear(); // 입력값 초기화
                                ref.read(feedSearchProvider.notifier).state =
                                    ''; // 검색 상태 초기화
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
