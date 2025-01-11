import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed/sentence_collection/data/models/sentence_model.dart';
import 'package:typed/sentence_collection/screens/sentence_list_page.dart';
import 'package:typed/sentence_collection/state/sentence_provider.dart';

class SentenceInputPage extends StatefulWidget {
  @override
  _SentenceInputPageState createState() => _SentenceInputPageState();
}

class _SentenceInputPageState extends State<SentenceInputPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isPublic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("문장 추가"),
        actions: [
          TextButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                // 문장 추가 로그
                print(
                    'Adding Sentence: ${_textController.text}, isPublic: $_isPublic');

                // Provider를 통해 문장 추가
                Provider.of<SentenceProvider>(context, listen: false)
                    .addSentence(
                  Sentence(
                    content: _textController.text,
                    isPublic: _isPublic,
                    createdAt: DateTime.now(),
                  ),
                );

                // 문장 리스트 페이지로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SentenceListPage(),
                  ),
                );
              } else {
                // 에러 처리: 빈 텍스트일 경우
                print('Error: Text is empty');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('문장을 입력해주세요')),
                );
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // 텍스트 색상
              textStyle: TextStyle(fontSize: 16),
            ),
            child: Text('완료'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 14,
              decoration: InputDecoration(
                hintText: '문장을 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('공개'),
                Switch(
                  value: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
