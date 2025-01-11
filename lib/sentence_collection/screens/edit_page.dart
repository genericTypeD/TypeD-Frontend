import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed/sentence_collection/data/models/sentence_model.dart';
import 'package:typed/sentence_collection/state/sentence_provider.dart';

class EditPage extends StatefulWidget {
  final int index;

  EditPage({required this.index});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _controller;
  bool _isPublic = true;

  @override
  void initState() {
    super.initState();
    final sentence = Provider.of<SentenceProvider>(context, listen: false)
        .sentences[widget.index];
    _controller = TextEditingController(text: sentence.content);
    _isPublic = sentence.isPublic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("문장 수정"),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final updatedSentence = Sentence(
                  content: _controller.text,
                  isPublic: _isPublic,
                  createdAt: DateTime.now(),
                );
                Provider.of<SentenceProvider>(context, listen: false)
                    .updateSentence(widget.index, updatedSentence);
                Navigator.pop(context); // 수정 후 돌아가기
              }
            },
            child: Text(
              "완료",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
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
