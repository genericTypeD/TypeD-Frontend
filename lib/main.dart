import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/feed/screen/feed_list_page.dart';
import 'package:typed/menu/screen/my_account.dart';
import 'package:typed/review/screen/reading_empty_page.dart';
import 'package:typed/sentence/screen/empty_page.dart';
import 'package:typed/type/screen/my_type.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultLayoutWithNavigation(), // DefaultLayout을 루트로 설정
    );
  }
}

class DefaultLayoutWithNavigation extends StatefulWidget {
  @override
  State<DefaultLayoutWithNavigation> createState() =>
      _DefaultLayoutWithNavigationState();
}

class _DefaultLayoutWithNavigationState
    extends State<DefaultLayoutWithNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MyType(),
    ReadingEmptyPage(),
    EmptyPage(),
    FeedListPage(),
    MyAccount(),
  ];

  final List<String> _titles = [
    'My Type',
    '서평 메모',
    '문장 수집',
    '취향 탐색',
    '나의 계정',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: _titles[_currentIndex], // 현재 페이지 제목
      currentIndex: _currentIndex, // 현재 선택된 인덱스
      child: _pages[_currentIndex], // 현재 페이지를 child로 전달
      onItemTapped: (index) {
        setState(() {
          _currentIndex = index; // 탭 전환 처리
        });
      },
    );
  }
}
