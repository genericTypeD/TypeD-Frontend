import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/layout/default_layout.dart'; // DefaultLayout 임포트
import 'package:typed/feed/screen/feed_list.dart';
import 'package:typed/menu/screen/my_menu.dart';
import 'package:typed/review/screen/review_empty.dart';
import 'package:typed/sentence/screen/sentence_empty.dart';
import 'package:typed/type/screen/my_type.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 2; // 기본적으로 문장 수집 페이지로 시작

  final List<Widget> _pages = [
    const MyType(), // My Type
    const ReviewEmpty(), // 서평 메모
    const SentenceEmpty(), // 문장 수집
    const FeedList(), // 취향 탐색
    const MyMenu(), // 나의 메뉴
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
      //title: _titles[_currentIndex], // 현재 탭에 맞는 제목을 전달
      bottomNavigationBar: _buildBottomNavigationBar(),
      //title: _titles[_currentIndex], // 현재 탭에 맞는 제목을 전달
      child: _pages[_currentIndex], // 내비게이션 바 전달
    );
  }

  // 내비게이션 바를 관리하는 함수
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // backgroundColor: const Color(0xFFFFFFFF),
      backgroundColor: AppColors.backgroundSecondary,
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
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline), label: '서평 메모'),
        BottomNavigationBarItem(
            icon: Icon(Icons.mode_edit_outlined), label: '문장 수집'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '취향 탐색'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: '나의 메뉴'),
      ],
    );
  }
}
