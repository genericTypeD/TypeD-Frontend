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
          selectedItemColor: AppColors.textPrimary,
          unselectedItemColor: AppColors.textTertiary,
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) {
            navigationShell.goBranch(index);
          },
          items: [
            // 0: MyType
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'My Type',
            ),

            // 1: 서평
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book_sharp,
              ),
              label: '서평',
            ),

            // 2: 기록
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () => context.push('/sentence_input'),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.backgroundTertiary,
                  child: const Icon(
                    Icons.add,
                    size: 24,
                    color: AppColors.backgroundQuaternary,
                  ),
                ),
              ),
              label: '',
            ),

            // 3: 문장
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.text_snippet_sharp,
              ),
              label: '문장',
            ),

            // 4: 피드
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.album_outlined,
              ),
              label: '취향 탐색',
            ),
          ],
        ),
      ),
    );
  }
}
