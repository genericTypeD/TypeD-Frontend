import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/models/lock_enum.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';

class SentenceList extends ConsumerStatefulWidget {
  const SentenceList({super.key});

  @override
  _SentenceListState createState() => _SentenceListState();
}

class _SentenceListState extends ConsumerState<SentenceList>
    with SingleTickerProviderStateMixin {
  static const _sentenceListScreenTitle = '문장 목록';
  static const _sentenceEmptyListText = '저장된 문장이 없습니다';

  late LockStatus _currentLockState;

  @override
  void initState() {
    super.initState();
    _currentLockState = LockStatus.closed;

    Future.microtask(() {
      ref.read(sentenceListProvider.notifier).fetchSentences();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sentences = ref.watch(sentenceListProvider);

    final privateSentences = sentences.where((s) => !s['isPublic']).toList();
    final publicSentences = sentences.where((s) => s['isPublic']).toList();

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
            "비공개 ${privateSentences.length} • 공개 ${publicSentences.length}",
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
                  _buildSentenceList(privateSentences),
                  _buildSentenceList(publicSentences),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 문장 리스트 UI 빌드 함수 (수정 및 삭제 기능 추가)
  Widget _buildSentenceList(List<dynamic> sentences) {
    if (sentences.isEmpty) {
      return Center(
        child: Text(
          "저장된 문장이 없습니다.",
          style: AppTheme.body1.copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      itemCount: sentences.length,
      itemBuilder: (context, index) {
        final sentence = sentences[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Text(
                sentence['content'],
                style: AppTheme.body1,
              ),
              subtitle: Text(
                sentence['createdAt'].substring(0, 10), // YYYY-MM-DD 형식
                style:
                    AppTheme.caption1.copyWith(color: AppColors.textSecondary),
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (value == 'edit') {
                    context.go('/sentence_edit', extra: {
                      'sentenceId': sentence['id'],
                      'initialContent': sentence['content'],
                      'isPublic': sentence['isPublic'],
                    });
                  } else if (value == 'delete') {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("삭제 확인"),
                        content: Text("이 문장을 삭제하시겠습니까?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text("취소"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text("삭제"),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      await ref
                          .read(sentenceListProvider.notifier)
                          .deleteSentence(sentence['id']);
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'edit', child: Text("수정")),
                  PopupMenuItem(value: 'delete', child: Text("삭제")),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
