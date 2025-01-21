import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final AppBar? appBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: appBar ?? _buildDefaultAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? _buildDefaultAppBar() {
    if (title == null) return null;

    return AppBar(
      backgroundColor: const Color(0xFFF3F3F2),
      foregroundColor: Colors.black,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 120.0, // Leading 영역 확장
      leading: Row(
        children: [
          const SizedBox(width: 16.0), // 좌측 패딩
          VerticalDivider(
            thickness: 0.3,
            width: 1.0,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // 구분선과 텍스트 간격
            child: GestureDetector(
              onTap: () {
                // TypeD 클릭 동작
              },
              child: const Text(
                'TypeD',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0), // 아이콘 우측 간격
              child: GestureDetector(
                onTap: () {
                  // 알림 아이콘 클릭 동작
                },
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
            ),
            VerticalDivider(
              thickness: 0.3,
              width: 1.0,
              color: Colors.black, // 수직 구분선
            ),
            const SizedBox(width: 16.0),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(
          height: 1.0,
          thickness: 0.3,
          color: Colors.black, // 수평 구분선
        ),
      ),
    );
  }
}
