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
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: Text(
          '취향 탐색',
          style: AppTheme.title3,
        ),
        bottomRightWidget: IconButton(
          onPressed: () => context.push('/feed_search'),
          icon: const Icon(
            Icons.search,
            color: Colors.black54,
          ),
        ),
      ),
      child: Container(
        color: AppColors.backgroundSecondary,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text('취향 탐색 피드입니다.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
