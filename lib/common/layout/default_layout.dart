import 'package:flutter/material.dart';
import 'package:typed/common/screen/splash.dart'; // SplashScreen 감지 위해 추가

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBar,
    Key? key,
  }) : super(key: key);

  /// `context`를 기반으로 `Scaffold`가 이미 존재하는지 확인
  bool _hasAncestorScaffold(BuildContext context) {
    return context.findAncestorWidgetOfExactType<Scaffold>() != null;
  }

  /// `SplashScreen` 또는 `SafeArea`일 경우 AppBar를 제거하는 로직 추가
  bool _shouldShowAppBar(BuildContext context) {
    if (appBar != null) return true; // 사용자가 명시적으로 `appBar` 제공 시 적용

    // child`가 `SplashScreen` 또는 `SafeArea`면 `AppBar` 생성 안 함
    if (child is SplashScreen || child is SafeArea) return false;

    // 기존 코드 유지: `Scaffold` 중복 방지
    return !_hasAncestorScaffold(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F2),

      /// `_shouldShowAppBar`를 사용하여 AppBar 생성 여부 결정
      appBar: _shouldShowAppBar(context) ? _buildAppBar() : null,

      body: Container(
        color: Colors.white,
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  /// 기본 `AppBar` 정의 (TypeD 타이틀 & 상/하단 라인 포함)
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF3F3F2),
            border: Border(
              top: BorderSide(color: Colors.black, width: 0.3),
              bottom: BorderSide(color: Colors.black, width: 0.3),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            titleSpacing: 0,
            title: Row(
              children: [
                const SizedBox(width: 16.0),
                Container(
                  width: 0.3,
                  height: kToolbarHeight,
                  color: Colors.black,
                ),
                const SizedBox(width: 12.0),
                const Text(
                  'TypeD',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        // 알림 아이콘 클릭 동작 추가 가능
                      },
                      child:
                          const Icon(Icons.notifications, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: kToolbarHeight,
                    child: const VerticalDivider(
                        thickness: 0.3, width: 1.0, color: Colors.black),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
