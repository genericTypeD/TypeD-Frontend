import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:typed/sentence/repository/sentence_repository.dart';

// Repository Provider (API 요청 담당)
final sentenceRepositoryProvider = Provider<SentenceRepository>((ref) {
  return SentenceRepository();
});

// 문장 목록 Provider (자동으로 fetchSentences() 실행)
final sentenceListProvider =
    StateNotifierProvider<SentenceListNotifier, AsyncValue<List<Sentence>>>(
        (ref) {
  final repository = ref.read(sentenceRepositoryProvider);
  return SentenceListNotifier(repository).._fetchSentences(); // 자동으로 API 호출
});

/// 공개 문장 필터링 Provider
final publicSentencesProvider = Provider<List<Sentence>>((ref) {
  final sentencesState = ref.watch(sentenceListProvider);
  return sentencesState.when(
    data: (sentences) =>
        sentences.where((sentence) => sentence.isPublic).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

/// 비공개 문장 필터링 Provider
final privateSentencesProvider = Provider<List<Sentence>>((ref) {
  final sentencesState = ref.watch(sentenceListProvider);
  return sentencesState.when(
    data: (sentences) =>
        sentences.where((sentence) => !sentence.isPublic).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

class SentenceListNotifier extends StateNotifier<AsyncValue<List<Sentence>>> {
  final SentenceRepository _repository;

  SentenceListNotifier(this._repository) : super(const AsyncValue.loading()) {
    _fetchSentences();
  }

  //// 문장 목록 불러오기
  Future<void> _fetchSentences() async {
    state = AsyncValue.loading(); // 로딩 상태로 변경

    try {
      final sentences = await _repository.fetchAllSentences();
      state = AsyncValue.data(sentences); // 데이터 설정
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace); // 에러 상태 설정
    }
  }

  /// 문장 추가
  Future<void> addSentence(String content, bool isPublic) async {
    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty) {
      return;
    }

    final newId = await _repository.getNextSentenceId();
    final newSentence = Sentence(
      id: newId,
      content: content,
      isPublic: isPublic,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    await _repository.addSentence(newSentence);

    _fetchSentences();
  }

  /// 문장 수정
  Future<void> updateSentence(int id, String content, bool isPublic) async {
    if (content.trim().isEmpty) {
      throw Exception('문장 내용을 입력해주세요.');
    }

    final existingSentence = _repository.getSentenceById(id); // 기존 문장 찾기
    if (existingSentence == null) {
      throw Exception('문장을 찾을 수 없습니다.');
    }

    final updatedSentence = existingSentence.copyWith(
      sentenceContent: content.trim(),
      sentenceIsPublic: isPublic,
      sentenceUpdatedAt: DateTime.now().toIso8601String(),
    ); // 업데이트된 문장
    await _repository.updateSentence(updatedSentence); // 저장소에 업데이트

    _fetchSentences(); // 상태 업데이트
  }

  /// 문장 삭제
  Future<void> deleteSentence(Sentence sentenceToDelete) async {
    await _repository.deleteSentence(sentenceToDelete);

    _fetchSentences(); // 상태 업데이트
  }
}
