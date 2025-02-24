import 'package:flutter/material.dart';
import 'package:typed/common/index.dart';

import '../../common/const/app_colors.dart';
import '../../common/screen/login_screen.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({super.key});

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      //appBar: CustomAppBar(),
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
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(), // 로그인 스크린 위젯
                ),
              );
            },
            child: Center(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
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
          ),
          const SizedBox(height: 16),
          // 통계 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('8', '내가 읽은 책'),
              _buildDivider(),
              _buildStatItem('-', '북마크'),
              _buildDivider(),
              _buildStatItem('80%', '문장 수집률'),
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
