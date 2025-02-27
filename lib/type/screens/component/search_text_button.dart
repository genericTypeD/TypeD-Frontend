import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class SearchTextButton extends StatefulWidget {
  final VoidCallback? onCancelButtonPressed;
  final TextEditingController? searchController;
  final Future<void> Function(String)? onSearchRequested;
  final bool isLoading;
  final ValueChanged<dynamic>? onListTileTap;
  final List<dynamic> searchResults;
  final String hintText; // '책 제목 혹은 작가의 이름을 검색하세요.'

  const SearchTextButton({
    this.onCancelButtonPressed,
    this.searchController,
    this.onSearchRequested,
    required this.isLoading,
    this.onListTileTap,
    required this.searchResults,
    required this.hintText,
    super.key,
  });

  @override
  State<SearchTextButton> createState() => _SearchTextButtonState();
}

class _SearchTextButtonState extends State<SearchTextButton> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = widget.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
                    onPressed: widget.onCancelButtonPressed,
                    child: Text(
                      '취소',
                      style: AppTheme.title3,
                    ),
                  ),
                  TextField(
                    autocorrect: false,
                    controller: widget.searchController,
                    cursorColor: Colors.black54,
                    cursorWidth: 1,
                    style: AppTheme.body1,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
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
                    onSubmitted: handleSearch,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: widget.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : ListView.builder(
                            itemCount: widget.searchResults.length,
                            itemBuilder: (context, index) {
                              final result = widget.searchResults[index];
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
                                onTap: () => widget.onListTileTap?.call(result),
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
    );
  }

  Future<void> handleSearch(String query) async {
    if (query.isEmpty) return;

    setState(() => isLoading = true);

    try {
      await widget.onSearchRequested?.call(query);
    } finally {
      setState(() => isLoading = false);
    }
  }
}
