import 'package:hive_flutter/hive_flutter.dart';
import 'package:typed/sentence/model/sentence_model.dart';

class SentenceRepository {
  final Box<Sentence> _box = Hive.box<Sentence>('sentence');

  /// 문장 저장 (POST)
  Future<String> addSentence(Sentence sentence) async {
    final key = await _box.add(sentence);
    return key.toString();
  }

  /// 문장 전체 목록 조회 (GET)
  Future<List<Sentence>> fetchAllSentences() async {
    return _box.values.toList();
  }

  /// ID로 특정 문장 조회 (GET)
  Sentence? getSentenceById(int id) {
    try {
      return _box.values.firstWhere((sentence) => sentence.id == id);
    } catch (e) {
      return null;
    }
  }

  /// ID로 특정 문장의 index 조회 (GET)
  int getSentenceIndex(Sentence sentenceToSearch) {
    final index = _box.values.toList().indexWhere(
          (sentence) => sentence.id == sentenceToSearch.id,
        );
    return index;
  }

  /// 문장 수정 (PUT)
  Future<void> updateSentence(Sentence sentenceToUpdate) async {
    final index = getSentenceIndex(sentenceToUpdate); // 해당 ID의 문장을 찾아 인덱스 확인

    if (index != -1) {
      await _box.putAt(index, sentenceToUpdate); // 해당 인덱스의 문장 수정
    } else {
      throw Exception('문장을 찾을 수 없습니다. ID: ${sentenceToUpdate.id}');
    }
  }

  /// 문장 삭제 (DELETE)
  Future<void> deleteSentence(Sentence sentenceToDelete) async {
    final index = getSentenceIndex(sentenceToDelete); // 해당 ID의 문장을 찾아 인덱스 확인

    if (index != -1) {
      await _box.deleteAt(index); // 해당 인덱스의 문장 삭제
    } else {
      throw Exception('문장을 찾을 수 없습니다. ID: $sentenceToDelete.id');
    }
  }

  /// ID AutoIncrement용 메소드
  Future<int> getNextSentenceId() async {
    if (_box.isEmpty) {
      return 1;
    }

    int maxId = 0;
    for (var sentence in _box.values) {
      if (sentence.id > maxId) {
        maxId = sentence.id;
      }
    }
    return maxId + 1;
  }
}
