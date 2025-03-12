import 'package:flutter/material.dart';
import 'package:typed/type/models/dummies/dummy_sentences.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/views/component/my_sentence_widget.dart';
import 'package:typed/type/views/layout/my_record_layout.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:uuid/uuid.dart';

class MySentenceRecordScreen extends StatefulWidget {
  final GridItem? item;

  const MySentenceRecordScreen({this.item, super.key});

  @override
  State<MySentenceRecordScreen> createState() => _MySentenceRecordScreenState();
}

class _MySentenceRecordScreenState extends State<MySentenceRecordScreen> {
  // TODO: - 선택된 문장 맨 앞으로
  Sentence? currentSentence;

  @override
  void initState() {
    super.initState();

    final item = widget.item;

    if (item != null && item.isSentence && item.isValid) {
      final existingSentence = Sentence(
        content: item.sentence!.content,
        isPublic: item.sentence!.isPublic,
        createdAt: item.sentence!.createdAt,
      );
      currentSentence = existingSentence;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyRecordLayout(
      onBottomLeftWidgetPressed: () => Navigator.pop(context),
      onBottomRightWidgetPressed: () async {
        if (currentSentence != null) {
          final result = GridItem.sentence(
            id: Uuid().v4(),
            sentence: currentSentence!,
          );
          Navigator.pop(context, result);
        }
      },
      body: ListView.builder(
        itemCount: dummySentences.length,
        itemBuilder: (BuildContext context, int index) {
          final item = dummySentences[index];

          return MySentenceWidget(
            onTap: () {
              setState(() {
                currentSentence = item;
              });
            },
            isSelected: (currentSentence != null &&
                currentSentence!.content == item.content &&
                currentSentence!.createdAt == item.createdAt),
            sentence: item,
          );
        },
      ),
    );
  }
}
