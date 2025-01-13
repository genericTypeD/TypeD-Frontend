import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';

import 'sentence_detail_page.dart';

class SentenceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sentences = Provider.of<SentenceProvider>(context).sentences;

    return Scaffold(
      appBar: AppBar(title: Text("문장 목록")),
      body: ListView.builder(
        itemCount: sentences.length,
        itemBuilder: (context, index) {
          final sentence = sentences[index];
          return ListTile(
            title: Text(
              sentence.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(sentence.createdAt.toLocal().toString()),
            onTap: () {
              // SentenceDetailPage로 데이터 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SentenceDetailPage(
                    index: index,
                    sentence: sentence,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
