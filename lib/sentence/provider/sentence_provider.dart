import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/sentence/repository/sentence_repository.dart';

// Repository Provider (API 요청 담당)
final sentenceRepositoryProvider = Provider<SentenceRepository>((ref) {
  return SentenceRepository();
});

// 문장 목록 Provider (자동으로 fetchSentences() 실행)
final sentenceListProvider =
    StateNotifierProvider<SentenceListNotifier, List<Map<String, dynamic>>>(
        (ref) {
  final repository = ref.read(sentenceRepositoryProvider);
  return SentenceListNotifier(repository)..fetchSentences(); // 자동으로 API 호출
});

class SentenceListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final SentenceRepository _repository;

  SentenceListNotifier(this._repository) : super([]);

  // 문장 목록 불러오기
  Future<void> fetchSentences() async {
    final sentences = await _repository.fetchSentences();
    if (sentences != null) {
      state = List<Map<String, dynamic>>.from(sentences);
    }
  }

  // 문장 추가
  Future<void> addSentence(String content, bool isPublic) async {
    final newSentence = await _repository.saveSentence(content, isPublic);
    if (newSentence != null) {
      state = [...state, newSentence];
    }
  }

  // 문장 수정
  Future<void> updateSentence(int id, String content, bool isPublic) async {
    final success = await _repository.updateSentence(id, content, isPublic);
    if (success) {
      state = state.map((sentence) {
        if (sentence['id'] == id) {
          return {
            ...sentence,
            "content": content,
            "isPublic": isPublic,
          };
        }
        return sentence;
      }).toList();
    }
  }

  // 문장 삭제
  Future<void> deleteSentence(int id) async {
    final success = await _repository.deleteSentence(id);
    if (success) {
      state = state.where((sentence) => sentence['id'] != id).toList();
    }
  }
}
