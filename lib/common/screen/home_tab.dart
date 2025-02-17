import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/feed/screen/feed_list.dart';
import 'package:typed/menu/screen/my_menu.dart';
import 'package:typed/review/screen/review_empty.dart';
import 'package:typed/sentence/screen/sentence_empty.dart';
import 'package:typed/type/screen/my_type.dart';

import '../../sentence/screen/sentence_input.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 2; // 기본적으로 문장 수집 페이지로 시작

  final List<Widget> _pages = [
    const MyType(),
    const ReviewEmpty(),
    const SentenceEmpty(),
    const FeedList(),
    const MyMenu(),
  ];

  void _navigateToSentenceInput(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SentenceInput(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // 아래에서 시작
          const end = Offset.zero; // 최종 위치
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: _buildBottomNavigationBar(context),
      child: _pages[_currentIndex], // 현재 선택된 페이지 표시
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.backgroundSecondary,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: (int index) {
        if (index == 2) {
          _navigateToSentenceInput(context); // ✅ 문장 입력 화면으로 전환
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My Type'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline), label: '서평 메모'),
        BottomNavigationBarItem(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundTertiary,
            ),
            child: const Icon(Icons.add,
                size: 24, color: AppColors.backgroundQuaternary),
          ),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '취향 탐색'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: '나의 메뉴'),
      ],
    );
  }
}
