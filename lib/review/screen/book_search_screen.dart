import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/viewmodels/book/book_providers.dart';
import 'package:typed/review/models/book_model.dart';

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
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      ref.read(searchQueryProvider.notifier).state = query;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(bookSearchProvider(searchQuery));

    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        bottomLeftWidget: Text(
          _bookScreenTitle,
          textAlign: TextAlign.left,
          style: AppTheme.title3,
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
                    return _buildBookItem(context, book);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) {
                debugPrint('[검색 오류] $error');
                return Center(
                  child: Text(
                    '검색 중 오류가 발생했습니다 🙏',
                    style: AppTheme.body2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedBookProvider.notifier).state = book;
        context.push('/review_input');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.backgroundTertiary,
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: AppColors.borderBlack,
                  width: 0.3,
                ),
              ),
              child: book.thumbnail.isNotEmpty
                  ? Image.network(
                      book.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: _buildPlaceholder(0.06),
                        );
                      },
                    )
                  : Center(
                      child: _buildPlaceholder(0.1),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBookItemText(book.title),
                  const SizedBox(height: 4),
                  _buildBookItemText(book.author),
                  const SizedBox(height: 4),
                  _buildBookItemText(book.publisher),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookItemText(String text) {
    return Text(
      text,
      style: AppTheme.body2,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
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
          _buildPlaceholder(0.1),
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
          _buildPlaceholder(0.1),
          const SizedBox(height: 16),
          Text(
            _emptyBookResult,
            style: AppTheme.body2,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(double size) {
    return Image.asset(
      'assets/images/grid_item_placeholder.png',
      width: MediaQuery.of(context).size.width * size,
      height: MediaQuery.of(context).size.width * size,
    );
  }
}
