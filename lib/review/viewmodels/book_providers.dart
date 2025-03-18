import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/config/env.dart';
import 'package:typed/review/data/repositories/book_respository.dart';
import 'package:typed/review/data/models/book_model.dart';

/// 책 검색 API를 위한 Repository Provider
// TODO: - dispose
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final kakaoApiKey = Env.kakaoRestApiKey;
  final repository = BookRepository(kakaoApiKey: kakaoApiKey);

  return repository;
});

/// 책 검색 쿼리용 Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// 책 검색 결과 BookSearchResult Provider
final bookSearchResultProvider =
    FutureProvider.family<BookSearchResult, String>((ref, query) async {
  if (query.isEmpty) {
    return BookSearchResult.fromJson({
      'documents': [],
      'meta': {'is_end': true, 'pageable_count': 0, 'total_count': 0}
    });
  }

  final repository = ref.read(bookRepositoryProvider);
  return repository.searchBooks(query);
});

/// 책 검색 결과 BookSearchResult에서 documents만 반환한 Provider
final bookSearchProvider =
    FutureProvider.family<List<Book>, String>((ref, query) async {
  final result = await ref.watch(bookSearchResultProvider(query).future);
  return result.documents;
});

/// 선택된 책 Provider
final selectedBookProvider = StateProvider<Book?>((ref) => null);
