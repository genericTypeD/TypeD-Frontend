import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';

class SentenceEmpty extends StatelessWidget {
  const SentenceEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        children: [
          // 상단 구분선
          // Container(
          //   height: 0.3,
          //   width: double.infinity,
          //   color: Colors.black,
          // ),

          // 중앙 컨테이너
          Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F3F2),
            ),
            child: Row(
              children: [
                // 왼쪽 구분선과 텍스트A
                Row(
                  children: [
                    const SizedBox(width: 16.0), // 좌측 여백
                    Container(
                      width: 0.3,
                      height: double.infinity,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 12.0), // 텍스트A 간격
                    const Text(
                      "텍스트A",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(width: 60.0), // 텍스트A와 구분선 간격
                Container(
                  width: 0.3,
                  height: double.infinity,
                  color: Colors.black,
                ),

                const Spacer(), // 텍스트A와 텍스트B 사이 간격
                // 텍스트B와 글쓰기, 오른쪽 구분선
                Row(
                  children: [
                    const Text(
                      "텍스트B",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 20.0), // 텍스트B와 글쓰기 사이 간격
                    const Text(
                      "글쓰기",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 14.0),
                    Container(
                      width: 0.3,
                      height: double.infinity,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 16.0), // 우측 여백
                  ],
                ),
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
          const Expanded(
            child: Center(
              child: Text("아직 수집된 문장이 없습니다."),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/sentence_input');
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
