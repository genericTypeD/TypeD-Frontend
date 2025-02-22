import 'package:flutter/material.dart';
import 'package:typed/type/model/book_model.dart';
import 'package:typed/common/const/app_bar_style.dart';
import 'package:typed/type/component/grid_text_item.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/config/env.dart';
import 'package:typed/common/index.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class MyBookRecordScreen extends StatefulWidget {
  const MyBookRecordScreen({super.key});

  @override
  State<MyBookRecordScreen> createState() => _MyBookRecordScreenState();
}

class _MyBookRecordScreenState extends State<MyBookRecordScreen> {
  static const String _apiKey = Env.kakaoRestApiKey;

  List<Book> searchResults = [];
  bool isLoading = false;
  final searchController = TextEditingController();

  Book? selectedBook;
  List<Book> currentBooks = [];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: const Text(
            '뒤로 가기',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        bottomCenterWidget: TextButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              barrierColor: Colors.black54,
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            searchController.text = '';
                            searchResults = [];
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          '취소',
                          style: AppTheme.title3,
                        ),
                      ),
                      TextField(
                        autocorrect: false,
                        controller: searchController,
                        cursorColor: Colors.black54,
                        cursorWidth: 1,
                        style: AppTheme.body1,
                        decoration: InputDecoration(
                          hintText: '책 제목 혹은 작가의 이름을 검색하세요.',
                          hintStyle: AppTheme.body1,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.3,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          if (value == searchController.text) {
                            searchBooks(value);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : ListView.builder(
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  final result = searchResults[index];
                                  return ListTile(
                                    leading: Image.network(
                                      result.thumbnail,
                                      width: 50,
                                      height: 50,
                                    ),
                                    title: Text(
                                      result.title,
                                    ),
                                    subtitle: Text(
                                      result.authors.join(', '),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedBook = result;
                                        debugPrint(
                                            'result.title: ${result.title}');
                                        currentBooks.insert(0, result);
                                        searchController.text = '';
                                        searchResults = [];
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Text(
            '검색하기',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1,
            ),
          ),
        ),
        bottomRightWidget: TextButton(
          onPressed: selectedBook != null
              ? () async {
                  try {
                    final response =
                        await http.get(Uri.parse(selectedBook!.thumbnail));
                    final uniqueFileName =
                        'album_image_${selectedBook!.isbn}_${DateTime.now().millisecondsSinceEpoch}.jpg';
                    final tempDir = await getTemporaryDirectory();
                    final file = File('${tempDir.path}/$uniqueFileName');
                    await file.writeAsBytes(response.bodyBytes);
                    final result = GridItemData(
                      imageFile: XFile(file.path),
                    );
                    Navigator.pop(context, result);
                    // Don't use 'BuildContext's across async gaps. Try rewriting the code to not use the 'BuildContext', or guard the use with a 'mounted' check.
                  } catch (e) {
                    debugPrint('[Saving Image Error] $e');
                  }
                }
              : null,
          child: const Text(
            '기록하기',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppBarStyle.borderContainerWidth,
            decoration: const BoxDecoration(
              color: Color(0xffF3F3F2),
              border: Border(right: AppBarStyle.borderStyle),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xffF3F3F2),
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: AppBarStyle.borderStyle),
                  ),
                  child: Column(
                    children: [
                      Padding(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.music_note,
                                                    size: 50),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
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
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        currentBook.title,
                                                        style: AppTheme.title3,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Flexible(
                                                      child: Text(
                                                        currentBook.authors
                                                            .join(', '),
                                                        style: AppTheme.body3
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
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
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Image.asset(
                                                    'assets/images/grid_item_placeholder.png',
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: AppBarStyle.borderContainerWidth,
            decoration: const BoxDecoration(
              color: Color(0xffF3F3F2),
              border: Border(left: AppBarStyle.borderStyle),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
