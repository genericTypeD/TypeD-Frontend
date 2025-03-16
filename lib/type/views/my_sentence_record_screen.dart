import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/ui/components/index.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/views/component/my_sentence_widget.dart';
import 'package:typed/type/views/layout/my_record_layout.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:uuid/uuid.dart';

class MySentenceRecordScreen extends ConsumerStatefulWidget {
  final GridItem? item;

  const MySentenceRecordScreen({this.item, super.key});

  @override
  ConsumerState<MySentenceRecordScreen> createState() =>
      _MySentenceRecordScreenState();
}

class _MySentenceRecordScreenState
    extends ConsumerState<MySentenceRecordScreen> {
  // TODO: - 선택된 문장 맨 앞으로
  Sentence? currentSentence;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(sentenceListProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sentencesState = ref.watch(sentenceListProvider);

    return sentencesState.when(
      data: (sentences) => MyRecordLayout(
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
          itemCount: sentences.length,
          itemBuilder: (BuildContext context, int index) {
            final item = sentences[index];

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
      ),
      error: (error, stackTrace) {
        debugPrint('$error');
        return _buildErrorScreen();
      },
      loading: () => CustomProgressIndicator(),
    );
  }

  // TODO: - 따로 구현
  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        children: [
          CustomPlaceholder(size: 0.1),
          Text(
            '오류가 발생했습니다.',
            style: AppTheme.body1,
          ),
        ],
      ),
    );
  }
}
