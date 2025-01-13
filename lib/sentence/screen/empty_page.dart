import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF3F3F2),
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
                child: const Text(
                  "아직 수집된 문장이 없습니다.",
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
        ),
      ],
    );
  }
}
