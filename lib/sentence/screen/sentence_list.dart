import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';

class SentenceList extends StatefulWidget {
  const SentenceList({super.key});

  @override
  _SentenceListState createState() => _SentenceListState();
}

class _SentenceListState extends State<SentenceList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int privateCount = 12; // 비공개 글 개수
  final int publicCount = 8; // 공개 글 개수

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: GestureDetector(
          onTap: () {
            debugPrint('클릭됨!');
          },
          child: Text(
            "문장 수집",
            style: AppTheme.title3,
          ),
        ),
        bottomRightWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Text(
            "비공개 $privateCount • 공개 $publicCount",
            style: AppTheme.title3,
          ),
        ),
      ),
      child: Container(
        color: AppColors.backgroundSecondary,
        child: Column(
          children: [
            Container(
              color: AppColors.backgroundSecondary,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.textPrimary,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "   비공개   "),
                  Tab(text: "   공개   "),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSentenceList(private: true),
                  _buildSentenceList(private: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 문장 리스트 UI 빌드 함수
  Widget _buildSentenceList({required bool private}) {
    Map<String, List<String>> groupedSentences = {
      "2024. 12": List.generate(7, (index) => "당신의 취향을 채워줄 문장을 기록해보세요."),
      "2024. 11": List.generate(5, (index) => "기록해보세요. 당신의 취향을 채워줄 문장을 ..."),
    };

    return SingleChildScrollView(
      child: Column(
        children: groupedSentences.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: private
                    ? AppColors.backgroundTertiary
                    : AppColors.backgroundTertiary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: AppTheme.title3,
                  ),
                  const SizedBox(height: 8),
                  ...entry.value.map((sentence) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sentence,
                            style: AppTheme.body1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "2/2/25",
                            style: AppTheme.caption1
                                .copyWith(color: AppColors.textSecondary),
                          ),
                          const Divider(),
                        ],
                      )),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
