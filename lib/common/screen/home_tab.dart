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
                Icons.menu_book_outlined,
              ),
              label: '서평메모',
            ),

            // 2: 기록
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  // 현재 활성화된 탭에 따라 다른 화면으로 이동
                  final currentIndex = navigationShell.currentIndex;

                  if (currentIndex == 1) {
                    // 인덱스가 1일 때 (서평 탭에 있을 때), 책 검색 화면으로 이동
                    context.push('/book_search');
                  } else if (currentIndex == 3) {
                    // 인덱스가 3일 때 (문장 탭에 있을 때), 문장 작성 화면으로 이동
                    context.push('/sentence_input');
                  }
                },
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
                Icons.text_snippet_outlined,
              ),
              label: '문장수집',
            ),

            // 4: 피드
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.radio_button_checked_rounded,
              ),
              label: '취향탐색',
            ),
          ],
        ),
      ),
    );
  }
}
