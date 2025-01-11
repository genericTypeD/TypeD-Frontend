import 'package:flutter/material.dart';
import 'package:typed/Explore tastes/screens/feed_list_page.dart';
import 'package:typed/member/screens/login_screen.dart';
import 'package:typed/my_type/screens/my_type.dart';
import 'package:typed/reading_note/screens/reading_empty_page.dart';

import 'sentence_input_page.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  int _selectedIndex = 2; // 기본값을 '문장 수집' 탭으로 설정

  // 페이지 전환용 위젯 리스트
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MyTypePage(),
      ReadingEmptyPage(),
      this.widget, // 현재 EmptyPage를 참조
      FeedListPage(),
      LoginScreen(),
    ];
  }

  // 네비게이션 바 아이템 클릭 시 호출
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // 동일한 탭 클릭 시 무시

    if (index == 2) {
      // 현재 페이지에서 처리 (문장 수집 페이지)
      setState(() {
        _selectedIndex = index;
      });
    } else {
      // 다른 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "문장 수집", // AppBar 제목 유지
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color(0xFFF3F3F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F2),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: const Center(
                  child: Text(
                    "사각형 박스 내용", // 기존 컨테이너 내용 유지
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: const Text(
                    "아직 수집된 문장이 없습니다.", // 기존 메시지 유지
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SentenceInputPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                backgroundColor: const Color(0xFFF3F3F2),
                foregroundColor: Colors.black,
              ),
              child: const Text(
                "+", // 플로팅 버튼 유지
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF3F3F2),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'My type',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '서평 메모',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: '문장 수집',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '취향 탐색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '나의 계정',
          ),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // 네비게이션 아이템 클릭 이벤트 처리
      ),
    );
  }
}
