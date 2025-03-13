import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/data/models/lock_enum.dart';
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
      ref.read(sentenceListProvider.notifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sentencesState = ref.watch(sentenceListProvider);

    return sentencesState.when(
      data: (sentences) {
        final privateSentences = ref.watch(privateSentencesProvider);
        final publicSentences = ref.watch(publicSentencesProvider);

        final displaySentences = _currentLockState == LockStatus.closed
            ? privateSentences
            : publicSentences;

        return DefaultLayout(
          backgroundColor: AppColors.backgroundSecondary,
          appBar: _buildAppbar(),
          child: Row(
            children: [
              Container(
                width: AppBarStyle.borderContainerWidth,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  border: Border(right: AppBarStyle.borderStyle),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SafeArea(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: AppBarStyle.borderStyle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.backgroundSecondary,
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                      child: _buildSentenceList(displaySentences),
                    ),
                  ),
                ),
              ),
              Container(
                width: AppBarStyle.borderContainerWidth,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  border: Border(left: AppBarStyle.borderStyle),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SafeArea(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: AppBarStyle.borderStyle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => _buildLoadingScreen(),
      error: (error, stackTrace) => _buildErrorScreen(),
    );
  }

  Widget _buildSentenceList(List<Sentence> sentences) {
    if (sentences.isEmpty) {
      return _buildEmptySentenceListScreen();
    }

    return ListView.builder(
      itemCount: sentences.length,
      itemBuilder: (context, index) {
        final sentence = sentences[index];

        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            border: Border(
              bottom: AppBarStyle.borderStyle,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  sentence.content,
                  style: AppTheme.body1,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  sentence.createdAt != null
                      ? 'createdAt: ${sentence.createdAt!.substring(0, 10)}'
                      : '',
                  style: AppTheme.body3,
                ),
              ),

              // 액션 버튼
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () {
                        context.push(
                          '/sentence_edit',
                          extra: {
                            'sentenceId': sentence.id,
                            'initialContent': sentence.content,
                            'isPublic': sentence.isPublic,
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => _buildAlertDialog(sentence),
                        );

                        if (confirmed == true && context.mounted) {
                          try {
                            await ref
                                .read(sentenceListProvider.notifier)
                                .deleteSentence(sentence);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('문장이 성공적으로 삭제되었습니다.'),
                                ),
                                snackBarAnimationStyle: AnimationStyle(
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          } catch (error) {
                            if (context.mounted) {
                              debugPrint('$error');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('오류로 인해 문장이 삭제되지 않았습니다.'),
                                ),
                                snackBarAnimationStyle: AnimationStyle(
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlertDialog(Sentence sentence) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: LinearBorder(
          side: BorderSide(
        width: 0.3,
        color: AppColors.borderBlack,
      )),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            '문장 삭제',
            style: AppTheme.title2,
          ),
          const SizedBox(height: 8),
          Text(
            '이 문장을 삭제하시겠습니까?',
            style: AppTheme.body1,
          ),
          const SizedBox(height: 8),
          Divider(
            thickness: 0.3,
            color: AppColors.borderBlack,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop(false);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop(false);
                    }
                  },
                  child: Text(
                    '취소',
                    style: AppTheme.body2,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop(true);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop(true);
                    }
                  },
                  child: Text(
                    '삭제',
                    style: AppTheme.body2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildEmptySentenceListScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlaceholder(0.1),
          const SizedBox(height: 16),
          Text(
            _sentenceEmptyListText,
            style: AppTheme.body2,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(double size) {
    return Image.asset(
      'assets/images/grid_item_placeholder.png',
      width: MediaQuery.of(context).size.width * size,
      height: MediaQuery.of(context).size.width * size,
    );
  }

  Widget _buildLoadingScreen() {
    return DefaultLayout(
      appBar: _buildLoadingErrorAppbar(),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return DefaultLayout(
      appBar: _buildLoadingErrorAppbar(),
      child: Center(
        child: Text(
          '🙏 문장 목록을 불러오는 중 오류가 발생했습니다.',
          style: AppTheme.body1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildLoadingErrorAppbar() {
    return CustomAppBar(
      bottomLeftWidget: Text(
        _sentenceListScreenTitle,
        style: AppTheme.title3,
        textAlign: TextAlign.left,
      ),
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      bottomLeftWidget: Text(
        _sentenceListScreenTitle,
        style: AppTheme.title3,
        textAlign: TextAlign.left,
      ),
      bottomRightWidget: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: DropdownButton<LockStatus>(
          value: _currentLockState,
          alignment: Alignment.centerRight,
          style: AppTheme.title3,
          dropdownColor: Colors.white,
          elevation: 0,
          icon: Container(),
          underline: Container(),
          items: [
            DropdownMenuItem<LockStatus>(
              value: LockStatus.closed,
              child: Row(
                children: [
                  const Icon(Icons.lock_outline, size: 14),
                  const SizedBox(width: 6),
                  Text(LockStatus.closed.korName),
                ],
              ),
            ),
            DropdownMenuItem<LockStatus>(
              value: LockStatus.open,
              child: Row(
                children: [
                  const Icon(Icons.lock_open, size: 14),
                  const SizedBox(width: 6),
                  Text(LockStatus.open.korName),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _currentLockState = value;
              });
            }
          },
        ),
      ),
    );
  }
}
