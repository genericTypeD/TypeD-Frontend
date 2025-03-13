import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/feed/provider/feed_search_provider.dart';

class FeedSearch extends ConsumerWidget {
  const FeedSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(feedSearchProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요...',
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) {
              ref.read(feedSearchProvider.notifier).state = value;
            },
          ),
        ),
        Expanded(
          child: searchQuery.isEmpty
              ? const Center(child: Text("검색 결과가 없습니다."))
              : ListView.builder(
                  itemCount: 10, // TODO: 실제 검색 결과 개수
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('검색 결과 $index'), // TODO: 실제 검색 데이터 적용
                      onTap: () {},
                    );
                  },
                ),
        ),
      ],
    );
  }
}
