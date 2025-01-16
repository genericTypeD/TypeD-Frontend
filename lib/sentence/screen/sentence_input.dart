import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart'; // DefaultLayout 임포트

class SentenceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "문장 입력", // 제목을 지정하여 앱 바에 표시
      child: const Center(
        child: Text("수집할 문장 입력 페이지입니다."),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context), // 내비게이션 바 추가
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFFF3F3F2),
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        // 탭 클릭 시 해당 화면으로 전환
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My Type'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '서평 메모'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: '문장 수집'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '취향 탐색'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '나의 계정'),
      ],
    );
  }
}
