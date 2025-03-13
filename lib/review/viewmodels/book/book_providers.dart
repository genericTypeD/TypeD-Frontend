import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/config/env.dart';
import 'package:typed/review/repositories/book_respository.dart';
import 'package:typed/review/models/book_model.dart';

/// 책 검색 API를 위한 Repository Provider
// TODO: - dispose
final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final kakaoApiKey = Env.kakaoRestApiKey;
  return BookRepository(kakaoApiKey: kakaoApiKey);
});

/// 책 검색 쿼리용 Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// 책 검색 결과용 Provider
final bookSearchProvider =
    FutureProvider.family<List<Book>, String>((ref, query) async {
  if (query.isEmpty) return [];

  final repository = ref.read(bookRepositoryProvider);
  return repository.searchBooks(query);
});

/// 선택된 책 Provider
final selectedBookProvider = StateProvider<Book?>((ref) => null);
