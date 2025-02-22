import 'package:flutter/material.dart';
import 'package:typed/type/model/book_model.dart';
import 'package:typed/common/const/app_bar_style.dart';
import 'package:typed/config/env.dart';
import 'package:typed/common/index.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class MyBookScreen extends StatefulWidget {
  const MyBookScreen({super.key});

  @override
  State<MyBookScreen> createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen> {
  static const String _apiKey = Env.kakaoRestApiKey;

  List<Book> searchResults = [];
  bool isLoading = false;
  final searchController = TextEditingController();
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
    return const MyTypeLayout(
      screenTheme: '책',
    );
  }
}
