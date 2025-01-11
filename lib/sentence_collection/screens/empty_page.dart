import 'package:flutter/material.dart';
import 'package:typed/Explore tastes/screens/feed_list_page.dart';
import 'package:typed/member/screens/login_screen.dart';
// 필요한 페이지 파일 import
import 'package:typed/my_type/screens/my_type.dart';
import 'package:typed/reading_note/screens/reading_empty_page.dart';

import 'sentence_input_page.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  int _selectedIndex = 2; // 기본값을 '문장 수집' 탭으로 설정

  // 하단 내비게이션 바 아이템에 따른 페이지 전환 로직
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // 현재 페이지 외 다른 탭 선택 시 화면 전환
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyTypePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReadingEmptyPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedListPage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "문장 수집",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color(0xFFF3F3F2), // AppBar 배경색 설정
        foregroundColor: Colors.black, // AppBar 텍스트 및 아이콘 색상 설정
        elevation: 0, // 그림자 제거
      ),
      backgroundColor: const Color(0xFFFFFFFF), // Scaffold 배경색 설정
      body: Column(
        children: [
          // 상단바 바로 아래에 위치할 컨테이너
          Container(
            height: 60,
            width: double.infinity, // 화면 너비를 가득 채움
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F2), // 컨테이너 배경색
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: const Center(
              child: Text(
                "사각형 박스 내용",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "아직 수집된 문장이 없습니다.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16), // 여백 추가
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SentenceInputPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(50, 50), // 버튼 크기 고정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // 둥근 모서리
                      ),
                      backgroundColor: const Color(0xFFF3F3F2), // 버튼 배경색
                      foregroundColor: Colors.black, // 텍스트 색상
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 24), // 텍스트 크기
                      textAlign: TextAlign.center, // 텍스트 정렬 명시
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, // 선택된 아이템 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
        onTap: _onItemTapped, // 아이템 클릭 이벤트 처리
      ),
    );
  }
}
