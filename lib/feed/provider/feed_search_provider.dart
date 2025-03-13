import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/feed/model/feed_model.dart';
import 'package:typed/feed/provider/feed_provider.dart';

final feedSearchProvider = StateProvider<String>((ref) => "");

final filteredFeedProvider = Provider<List<FeedModel>>((ref) {
  final query = ref.watch(feedSearchProvider);
  final allFeeds = ref.watch(feedProvider);

  return allFeeds
      .where((feed) =>
          feed.content.contains(query) ||
          (feed.hashtags?.any((tag) => tag.contains(query)) ?? false))
      .toList();
});
