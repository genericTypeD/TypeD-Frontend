import 'package:flutter/material.dart';
import 'package:typed/sentence_collection/data/models/sentence_model.dart';

class SentenceProvider extends ChangeNotifier {
  final List<Sentence> _sentences = []; // 문장 리스트

  List<Sentence> get sentences => _sentences;

  // 문장 추가
  void addSentence(Sentence sentence) {
    _sentences.add(sentence);
    notifyListeners(); // 상태 갱신
  }

  // 문장 삭제
  void deleteSentence(int index) {
    if (index >= 0 && index < _sentences.length) {
      _sentences.removeAt(index);
      notifyListeners(); // 상태 갱신
    }
  }

  // 문장 업데이트
  void updateSentence(int index, Sentence updatedSentence) {
    if (index >= 0 && index < _sentences.length) {
      _sentences[index] = updatedSentence; // 특정 인덱스의 문장 업데이트
      notifyListeners(); // 상태 갱신
    }
  }
}
