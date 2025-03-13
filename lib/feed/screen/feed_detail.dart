import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/index.dart';
import 'package:typed/feed/model/feed_model.dart';

class FeedDetail extends StatelessWidget {
  final FeedModel feed;

  const FeedDetail({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: const Text(
          "원문 보기",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.push('/my_type/${feed.userId}'),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(feed.profileImageUrl),
                    radius: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(feed.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Text(feed.content, style: const TextStyle(fontSize: 18)),
            IconButton(
              icon: Icon(
                  feed.isBookmarked ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () {
                // 북마크 기능 추가 예정
              },
            ),
          ],
        ),
      ),
    );
  }
}
