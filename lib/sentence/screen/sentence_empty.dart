import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class SentenceEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        children: [
          // 상단 구분선
          Container(
            height: 0.3,
            width: double.infinity,
            color: Colors.black,
          ),
          // 중앙 컨테이너
          Container(
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F3F2),
            ),
            child: Row(
              children: [
                // 왼쪽 구분선과 간격
                const SizedBox(width: 20.0),
                Container(
                  width: 0.3,
                  height: double.infinity,
                  color: Colors.black,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Center(
                    child: Text(
                      "사각형 박스 내용",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                // 오른쪽 구분선과 간격
                const SizedBox(width: 10.0),
                Container(
                  width: 0.3,
                  height: double.infinity,
                  color: Colors.black,
                ),
                const SizedBox(width: 20.0),
              ],
            ),
          ),
          // 하단 구분선
          Container(
            height: 0.3,
            width: double.infinity,
            color: Colors.black,
          ),
          // 아래 콘텐츠
          Expanded(
            child: Center(
              child: Text("아직 수집된 문장이 없습니다."),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/sentence_input'); // 문장 입력 페이지로 이동
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
          "+",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
