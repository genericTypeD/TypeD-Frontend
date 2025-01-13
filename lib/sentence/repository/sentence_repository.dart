// 데이터 처리 로직

import 'package:typed/sentence/model/sentence_model.dart';

class SentenceRepository {
  final List<Sentence> _sentences = []; // 임시 저장소 (나중에 DB로 대체 가능)

  List<Sentence> getAllSentences() {
    return _sentences;
  }

  void addSentence(Sentence sentence) {
    _sentences.add(sentence);
  }
}
