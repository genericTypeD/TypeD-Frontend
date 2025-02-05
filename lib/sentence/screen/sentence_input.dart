import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart'; // DefaultLayout 임포트

class SentenceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        titleSpacing: 0,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16.0), // 좌측 간격
            // Container(
            //   width: 0.3, // 수직 구분선 두께
            //   height: kToolbarHeight,
            //   color: Colors.black, // 수직 구분선 색상
            // ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // 뒤로가기 동작
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0), // 원하는 패딩 조정
                child: Icon(
                  Icons.arrow_back,
                  size: 20.0, // 화살표 크기
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        title: const Text(
          "문장 수집",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  // 완료 버튼 동작 추가
                  print("완료 버튼 클릭됨");
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // 기본 패딩 제거
                  minimumSize: const Size(0, kToolbarHeight), // 높이 조정
                ),
                child: const Text(
                  "완료",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              // Container(
              //   width: 0.3, // 수직 구분선 두께
              //   height: kToolbarHeight,
              //   color: Colors.black, // 수직 구분선 색상
              // ),
              const SizedBox(width: 16.0), // 우측 간격
            ],
          ),
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(1.0), // 구분선 높이
        //   child: Container(
        //     color: Colors.black, // 구분선 색상
        //     height: 0.3, // 구분선 두께
        //   ),
        // ),
      ),
      child: const Center(
        child: Text("수집할 문장 입력 페이지입니다."),
      ),
    );
  }
}
