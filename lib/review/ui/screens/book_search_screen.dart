import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/data/models/book_model.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';
import 'package:typed/review/ui/components/custom_progress_indicator.dart';
import 'package:typed/review/ui/screens/review_error_screen.dart';
import 'package:typed/review/ui/widgets/book_list_item.dart';
import 'package:typed/review/ui/widgets/book_search_text_field.dart';
import 'package:typed/review/viewmodels/book_providers.dart';

class BookSearchScreen extends ConsumerStatefulWidget {
  const BookSearchScreen({super.key});

  @override
  ConsumerState<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends ConsumerState<BookSearchScreen> {
  static const _bookSearchBodyText = '검색어를 입력해주세요';
  static const _emptyBookResult = '검색 결과가 없습니다';

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(searchQueryProvider.notifier).state = '';
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(bookSearchProvider(searchQuery));

    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () => context.pop(),
          child: Text(
            '돌아가기',
            textAlign: TextAlign.left,
            style: AppTheme.title3,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BookSearchTextField(
              searchController: _searchController,
              searchFocusNode: _searchFocusNode,
              onClearButtonPressed: () {
                _searchController.clear();
                ref.read(searchQueryProvider.notifier).state = '';
              },
              onSubmitted: (_) {
                final query = _searchController.text.trim();
                if (query.isNotEmpty) {
                  ref.read(searchQueryProvider.notifier).state = query;
                }
              },
            ),
          ),
          Expanded(
            child: searchResults.when(
              data: (books) {
                if (searchQuery.isEmpty) {
                  return _buildBookSearchBody();
                }
                if (books.isEmpty) {
                  return _buildEmptyBookResult();
                }

                return _buildBookList(books);
              },
              loading: () => CustomProgressIndicator(),
              error: (error, stackTrace) => ReviewErrorScreen.error(
                onBackButtonTap: () => Navigator.of(context).canPop(),
                onRefreshButtonTap: () => debugPrint('새로고침'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(List<Book> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookListItem(
          book: book,
          onTap: () {
            ref.read(selectedBookProvider.notifier).state = book;
            context.push('/review_input');
          },
        );
      },
    );
  }

  Widget _buildBookSearchBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPlaceholder(size: 0.1),
          const SizedBox(height: 8),
          Text(
            _bookSearchBodyText,
            style: AppTheme.body2,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyBookResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPlaceholder(size: 0.1),
          const SizedBox(height: 16),
          Text(
            _emptyBookResult,
            style: AppTheme.body2,
          ),
        ],
      ),
    );
  }
}
