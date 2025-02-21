import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/app_colors.dart';

class HomeTab extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeTab({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundSecondary,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) {
            navigationShell.goBranch(index); // 바텀 네비게이션 클릭 시 이동
          },
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'My Type'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline), label: '서평 메모'),

            // Add 버튼
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  context.go('/sentence_input');
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.backgroundTertiary,
                  child: const Icon(Icons.add,
                      size: 24, color: AppColors.backgroundQuaternary),
                ),
              ),
              label: '',
            ),

            const BottomNavigationBarItem(
                icon: Icon(Icons.search), label: '취향 탐색'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: '나의 메뉴'),
          ],
        ),
      ),
    );
  }
}
