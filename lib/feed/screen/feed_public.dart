import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';

class FeedPublic extends StatefulWidget {
  const FeedPublic({super.key});

  @override
  State<FeedPublic> createState() => _FeedPublicState();
}

class _FeedPublicState extends State<FeedPublic> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: Text(
            "취향 탐색",
            style: AppTheme.title3,
          ),
        ),
        bottomRightWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Container(
            width: 180, // 검색 입력란의 크기 조절
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: _searchController,
              cursorHeight: 16.0,
              cursorColor: AppColors.backgroundQuaternary,
              onTap: () {
                // 검색창 클릭 시 FeedSearch 페이지로 이동
                context.push('/feed_search');
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                hintText: "Search",
                hintStyle:
                    AppTheme.body2.copyWith(color: AppColors.textSecondary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              style: AppTheme.body1,
              onChanged: (value) {
                // 검색 기능 추가 가능
                debugPrint("검색어 입력: $value");
              },
            ),
          ),
        ),
      ),
      child: Container(
        color: AppColors.backgroundSecondary,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text("취향 탐색 피드입니다."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
