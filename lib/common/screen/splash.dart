import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart'; // DefaultLayout 임포트
import 'package:typed/common/screen/home_tab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> letters = ["T", "y", "p", "e", "D"];
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _startLetterAnimation();
  }

  void _startLetterAnimation() {
    for (int i = 0; i < letters.length; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        setState(() {
          currentIndex = i;
        });
      });
    }

    Future.delayed(Duration(milliseconds: letters.length * 500 + 500),
        navigateToEmptyPage);
  }

  void navigateToEmptyPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 50),
        pageBuilder: (context, animation, secondaryAnimation) =>
            HomeTab(), // SentenceEmpty로 이동
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: const Color(0xFFF3F3F2),
      child: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: letters.asMap().entries.map((entry) {
              int index = entry.key;
              String letter = entry.value;

              return Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    letter,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: currentIndex >= index
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ),
                  AnimatedAlign(
                    alignment: currentIndex == index
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    duration: const Duration(milliseconds: 30),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 30,
                      height: 40,
                      color: currentIndex >= index
                          ? Colors.transparent
                          : Colors.black,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
