import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/app_colors.dart';
import '../../common/provider/auth_provider.dart';

class MyMenu extends ConsumerStatefulWidget {
  const MyMenu({super.key});

  @override
  ConsumerState<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends ConsumerState<MyMenu> {
  @override
  Widget build(BuildContext context) {
    // AuthProvider의 상태 가져오기
    final authState = ref.watch(authProvider);

    return Drawer(
      backgroundColor: AppColors.backgroundSecondary,
      shape: Border.all(width: 0),
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          _buildProfileCard(),
          _buildMenuList(),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    // 로그인 상태 확인
    final authState = ref.watch(authProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFE6E6E6),
            child: Icon(
              Icons.person_outline,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          // 로그인 상태에 따라 다른 UI 표시
          authState.isLoggedIn
              ? Text(
                  '${authState.nickname ?? "사용자"}님',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    context.goNamed('login');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '로그인이 필요합니다',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                ),
          const SizedBox(height: 16),
          // 통계 정보
          Row(
            children: [
              Expanded(child: _buildStatItem('8', '나의 문장')),
              _buildDivider(),
              Expanded(child: _buildStatItem('2', '나의 서평')),
              _buildDivider(),
              Expanded(child: _buildStatItem('5', '북마크')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    final menuItems = [
      {'title': '로그인 정보', 'icon': Icons.person_outline},
      {'title': '고객센터', 'icon': Icons.headset_mic_outlined},
      {'title': '약관', 'icon': Icons.description_outlined},
    ];

    return Container(
      color: AppColors.backgroundSecondary,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey[300],
        ),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              menuItems[index]['icon'] as IconData,
              color: Colors.black,
            ),
            title: Text(menuItems[index]['title'] as String),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          );
        },
      ),
    );
  }
}
