import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:typed/type/models/book_model.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/views/layout/my_record_layout.dart';
import 'package:typed/type/views/component/search_text_button.dart';
import 'package:typed/config/env.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class MyBookRecordScreen extends StatefulWidget {
  final GridItem? item;

  const MyBookRecordScreen({
    this.item,
    super.key,
  });

  @override
  State<MyBookRecordScreen> createState() => _MyBookRecordScreenState();
}

class _MyBookRecordScreenState extends State<MyBookRecordScreen> {
  static const String _apiKey = Env.kakaoRestApiKey;

  // TODO: - private
  List<Book> searchResults = [];
  bool isLoading = false;
  final searchController = TextEditingController();

  Book? selectedBook;
  List<Book> currentBooks = [];

  @override
  void initState() {
    super.initState();

    if (widget.item != null && widget.item!.isValid && widget.item!.isBook) {
      // TODO: - 타입을 다 만들어야 하나?
      final book = widget.item!.book!;
      selectedBook = book;
      currentBooks.add(book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyRecordLayout(
      onBottomRightWidgetPressed: () =>
          selectedBook != null ? pushMyTypeScreen() : null,
      bottomCenterWidget: _renderBottomCenterWidget(),
      body: [
        _renderSelectedBookSection(context),
        _renderCurrentBooksSection(context),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _renderBottomCenterWidget() {
    return SearchTextButton(
      onCancelButtonPressed: () {
        debugPrint('cancel tapped');
        setState(() {
          searchController.text = '';
          searchResults = [];
        });
        Navigator.pop(context);
      },
      searchController: searchController,
      onSearchRequested: (query) async {
        return searchBooks(query);
      },
      isLoading: isLoading,
      onListTileTap: (value) {
        setState(() {
          selectedBook = value as Book;
          debugPrint('value.title: ${value.title}');
          currentBooks.insert(0, value);
          searchController.text = '';
          searchResults = [];
        });
        Navigator.pop(context);
      },
      searchResults: searchResults,
      hintText: '책 제목 혹은 작가의 이름을 검색하세요.',
    );
  }

  Widget _renderSelectedBookSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.22,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.3,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 8,
                      child: Text(
                        selectedBook?.title ?? '',
                        style: AppTheme.title2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      flex: 3,
                      child: Text(
                        selectedBook?.authors.first ?? '',
                        style: AppTheme.body3.copyWith(
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenHeight * 0.22,
              height: screenHeight * 0.22,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 0.3,
                  ),
                ),
              ),
              child: selectedBook != null
                  ? Image.network(
                      selectedBook!.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.music_note, size: 50),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderCurrentBooksSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.3,
            ),
          ),
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: screenWidth * 0.22,
            ),
            itemCount: currentBooks.length,
            itemBuilder: (context, index) {
              final currentBook = currentBooks[index];
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedBook = currentBook;
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.3,
                      ),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              ),
                            ),
                            child: Image.network(
                              currentBook.thumbnail,
                              width: screenWidth * 0.22,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      currentBook.title,
                                      style: AppTheme.title3,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Flexible(
                                    child: Text(
                                      currentBook.authors.join(', '),
                                      style: AppTheme.body3.copyWith(
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint('pin');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                            color: index % 2 != 0
                                ? Colors.white
                                : const Color(0xffF3F3F2),
                            border: const Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.3,
                              ),
                              left: BorderSide(
                                color: Colors.black,
                                width: 0.3,
                              ),
                            ),
                          ),
                          child: () {
                            if (index % 2 == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                  'assets/images/grid_item_placeholder.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) return;

    setState(() => isLoading = true);

    try {
      final response = await http.get(
        Uri.parse('https://dapi.kakao.com/v3/search/book?query=$query'),
        headers: {
          'Authorization': 'KakaoAK $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        final result = BookSearchResult.fromJson(jsonDecode(response.body));
        setState(() {
          searchResults = result.documents;
          isLoading = false;
        });
      } else {
        throw Exception('[Loading Books Fail Error]');
      }
    } catch (e) {
      debugPrint('$e');
      setState(() => isLoading = false);
    }
  }

  void pushMyTypeScreen() async {
    try {
      // final response = await http.get(Uri.parse(selectedBook!.thumbnail));
      // final uniqueFileName =
      //     'album_image_${selectedBook!.isbn}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // final tempDir = await getTemporaryDirectory();
      // final file = File('${tempDir.path}/$uniqueFileName');

      // await file.writeAsBytes(response.bodyBytes);

      // final result = GridItem(
      //   imageFile: XFile(file.path),
      // );
      // final result = GridItem.book(
      //   id: Uuid().v4(),
      //   title: selectedBook!.title,
      //   imagePath: file.path,
      // );

      if (selectedBook != null) {
        final result = GridItem.book(id: Uuid().v4(), book: selectedBook!);
        Navigator.pop(context, result);
      }
      // Don't use 'BuildContext's across async gaps. Try rewriting the code to not use the 'BuildContext', or guard the use with a 'mounted' check.
    } catch (e) {
      debugPrint('[Saving Image Error] $e');
    }
  }
}
