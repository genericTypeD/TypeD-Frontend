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
      title: Row(
        children: [
          const SizedBox(width: 20.0),
          // Container(
          //   width: 0.3,
          //   height: kToolbarHeight,
          //   color: Colors.black,
          // ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'TypeD',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // 알림 버튼 동작 추가
              },
              child: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
            ),
          ),
          // Container(
          //   width: 0.3,
          //   height: kToolbarHeight,
          //   color: Colors.black,
          // ),
          const SizedBox(width: 20.0),
        ],
      ),
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(1.0), // 구분선 높이
      //   child: Container(
      //     color: Colors.black, // 구분선 색상
      //     height: 0.3, // 구분선 두께
      //   ),
      // ),
    );
  }
}
