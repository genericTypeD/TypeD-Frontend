import 'package:flutter/material.dart';
import 'package:typed/feed/model/feed_model.dart';

class FeedCard extends StatelessWidget {
  final FeedModel feed;

  const FeedCard({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(feed.profileImageUrl),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Text(feed.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: Icon(feed.isBookmarked
                      ? Icons.bookmark
                      : Icons.bookmark_border),
                  onPressed: () {
                    // TODO: 북마크 기능 추가
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              feed.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              children: feed.hashtags
                      ?.map((tag) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(label: Text('#$tag')),
                          ))
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}
