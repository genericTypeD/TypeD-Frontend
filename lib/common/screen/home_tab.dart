import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart'; // DefaultLayout 임포트
import 'package:typed/feed/screen/feed_list.dart';
import 'package:typed/menu/screen/my_menu.dart';
import 'package:typed/review/screen/review_empty.dart';
import 'package:typed/sentence/screen/sentence_empty.dart';
import 'package:typed/type/screen/my_type.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 2; // 기본적으로 문장 수집 페이지로 시작

  final List<Widget> _pages = [
    MyType(), // My Type
    ReviewEmpty(), // 서평 메모
    SentenceEmpty(), // 문장 수집
    FeedListPage(), // 취향 탐색
    MyMenu(), // 나의 메뉴
  ];

  final List<String> _titles = [
    'My Type',
    '서평 메모',
    '문장 수집',
    '취향 탐색',
    '나의 메뉴',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: _titles[_currentIndex], // 현재 탭에 맞는 제목을 전달
      child: _pages[_currentIndex], // 현재 탭에 맞는 페이지를 전달
      bottomNavigationBar: _buildBottomNavigationBar(), // 내비게이션 바 전달
    );
  }

  // 내비게이션 바를 관리하는 함수
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFFFFFFFF),
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex, // 현재 탭의 인덱스
      onTap: (int index) {
        setState(() {
          _currentIndex = index; // 탭 클릭 시 해당 화면으로 전환
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My Type'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '서평 메모'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: '문장 수집'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '취향 탐색'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '나의 메뉴'),
      ],
    );
  }
}
