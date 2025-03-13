import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/index.dart';
import 'package:typed/feed/provider/feed_search_provider.dart';

class FeedSearch extends ConsumerWidget {
  const FeedSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: const Text(
          "검색",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "키워드 또는 해시태그 검색...",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            ref.read(feedSearchProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}
