import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final int currentIndex;
  final Widget child;
  final Function(int) onItemTapped;

  const DefaultLayout({
    required this.title,
    required this.currentIndex,
    required this.child,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF3F3F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: child, // 현재 선택된 페이지 렌더링
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF3F3F2),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My type'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '서평 메모'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: '문장 수집'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '취향 탐색'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '나의 계정'),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped, // 네비게이션 탭 변경 처리
      ),
    );
  }
}
