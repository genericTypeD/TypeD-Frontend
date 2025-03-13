import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/index.dart';
import 'package:typed/feed/provider/feed_provider.dart';
import 'package:typed/feed/screen/feed_list.dart';

class FeedPublic extends ConsumerWidget {
  const FeedPublic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feeds = ref.watch(feedProvider);

    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: Text(
          '공개된',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        bottomRightWidget: IconButton(
          onPressed: () => context.push('/feed_search'),
          icon: const Icon(Icons.search, color: Colors.black54),
        ),
      ),
      child: Container(
        color: AppColors.backgroundSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: feeds.isEmpty
            ? const Center(
                child: Text(
                  "새로운 취향을 탐색해보세요!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : FeedList(feeds: feeds),
      ),
    );
  }
}
