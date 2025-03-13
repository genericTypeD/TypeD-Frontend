import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/feed/model/feed_model.dart';
import 'package:typed/feed/repository/feed_repository.dart';

final feedProvider =
    StateNotifierProvider<FeedNotifier, List<FeedModel>>((ref) {
  return FeedNotifier();
});

class FeedNotifier extends StateNotifier<List<FeedModel>> {
  FeedNotifier() : super([]);

  final _repository = FeedRepository();

  Future<void> loadFeed() async {
    final feeds = await _repository.fetchFeed();
    state = feeds;
  }
}
