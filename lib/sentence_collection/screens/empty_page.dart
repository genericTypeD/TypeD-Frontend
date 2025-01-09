import 'package:flutter/material.dart';

import 'sentence_input_page.dart';

class EmptyPage extends StatelessWidget {
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
            height: 200,
            width: double.infinity, // 화면 너비를 가득 채움
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F2), // 컨테이너 배경색
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
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
                  const Text("아직 수집된 문장이 없습니다."),
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
                      fixedSize: const Size(60, 60), // 버튼 크기 고정
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
    );
  }
}
