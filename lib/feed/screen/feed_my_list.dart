import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/index.dart';
import 'package:typed/feed/provider/feed_provider.dart';
import 'package:typed/feed/screen/feed_list.dart';

class FeedMyListScreen extends ConsumerWidget {
  const FeedMyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myFeeds = ref.watch(feedProvider); // TODO: 내 피드만 필터링하는 로직 추가

    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: const Text(
          "내 리스트",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: myFeeds.isEmpty
            ? const Center(
                child: Text(
                  "아직 작성한 콘텐츠가 없습니다.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            : FeedList(feeds: myFeeds),
      ),
    );
  }
}
