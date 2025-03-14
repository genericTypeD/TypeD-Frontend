import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/ui/components/custom_placeholder.dart';
import 'package:typed/review/ui/components/custom_progress_indicator.dart';
import 'package:typed/review/ui/screens/review_error_screen.dart';
import 'package:typed/review/ui/widgets/book_search_result_widget.dart';
import 'package:typed/review/viewmodels/book_providers.dart';

class BookSearchScreen extends ConsumerStatefulWidget {
  const BookSearchScreen({super.key});

  @override
  ConsumerState<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends ConsumerState<BookSearchScreen> {
  static const _bookScreenTitle = '서평 메모';
  static const _bookSearchTextFieldHintText = '책 제목, 저자 등을 입력하세요';
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
            child: _buildBookSearchTextField(),
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

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookSearchResultWidget(
                      book: book,
                      onTap: () {
                        ref.read(selectedBookProvider.notifier).state = book;
                        context.push('/review_input');
                      },
                    );
                  },
                );
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

  Widget _buildBookSearchTextField() {
    return TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      autofocus: false,
      decoration: InputDecoration(
        hintText: _bookSearchTextFieldHintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            ref.read(searchQueryProvider.notifier).state = '';
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(
            color: AppColors.borderBlack,
            width: 0.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(
            color: AppColors.borderBlack,
            width: 0.6,
          ),
        ),
      ),
      onSubmitted: (_) => _performSearch(),
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

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      ref.read(searchQueryProvider.notifier).state = query;
    }
  }
}
