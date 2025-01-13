import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';
import 'package:typed/sentence/screen/edit_page.dart';

class SentenceDetailPage extends StatelessWidget {
  final int index;
  final Sentence sentence;

  SentenceDetailPage({required this.index, required this.sentence});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SentenceProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("문장 내용"),
        actions: [
          TextButton(
            onPressed: () {
              // EditPage로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(index: index), // EditPage 호출
                ),
              );
            },
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sentence.content,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "작성일: ${sentence.createdAt.toLocal()}",
              style: TextStyle(color: Colors.grey),
            ),
            Spacer(),
            // 공개/비공개 버튼
            TextButton(
              onPressed: () {
                final updatedSentence = Sentence(
                  content: sentence.content,
                  isPublic: !sentence.isPublic, // 공개 상태 반전
                  createdAt: sentence.createdAt,
                );
                provider.updateSentence(index, updatedSentence);
                Navigator.pop(context); // 상태 갱신 후 목록으로 돌아가기
              },
              child: Text(
                sentence.isPublic ? "비공개로 전환" : "공개로 전환",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
