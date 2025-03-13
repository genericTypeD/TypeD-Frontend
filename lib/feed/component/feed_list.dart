import 'package:flutter/material.dart';
import 'package:typed/feed/component/feed_card.dart';
import 'package:typed/feed/model/feed_model.dart';

class FeedList extends StatelessWidget {
  final List<FeedModel> feeds;

  const FeedList({super.key, required this.feeds});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        return FeedCard(feed: feeds[index]);
      },
    );
  }
}
