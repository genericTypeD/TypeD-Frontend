import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';

class BookSearchTextField extends StatelessWidget {
  static const _bookSearchTextFieldHintText = '책 제목, 저자 등을 입력하세요';

  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final VoidCallback onClearButtonPressed;
  final Function(String) onSubmitted;

  const BookSearchTextField({
    required this.searchController,
    required this.searchFocusNode,
    required this.onClearButtonPressed,
    required this.onSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      focusNode: searchFocusNode,
      autofocus: false,
      decoration: InputDecoration(
        hintText: _bookSearchTextFieldHintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => onClearButtonPressed(),
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
      onSubmitted: onSubmitted,
    );
  }
}
