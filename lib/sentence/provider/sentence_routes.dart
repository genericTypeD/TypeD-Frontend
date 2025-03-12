import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/sentence/screen/sentence_edit.dart';
import 'package:typed/sentence/screen/sentence_empty.dart';
import 'package:typed/sentence/screen/sentence_input.dart';
import 'package:typed/sentence/screen/sentence_list.dart';

class SentenceRoutes {
  static final List<GoRoute> routes = [
    /// 문장 목록 화면
    GoRoute(
      path: '/sentence_list',
      builder: (context, state) => const SentenceList(),
    ),

    /// 문장 수집 화면
    GoRoute(
      path: '/sentence_input',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const SentenceInput(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero, // 현재 위치로 슬라이드
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    ),

    /// 빈 문장 화면
    GoRoute(
      path: '/sentence_empty',
      builder: (context, state) => const SentenceEmpty(),
    ),

    /// 문장 편집 화면
    GoRoute(
      path: '/sentence_edit',
      pageBuilder: (context, state) {
        debugPrint('/sentence_edit');
        final args = state.extra as Map<String, dynamic>?;
        if (args == null) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: DefaultLayout(
              appBar: CustomAppBar(
                bottomLeftWidget: Text(
                  'error',
                  style: AppTheme.title3,
                ),
              ),
              child: Center(
                child: Text(
                  '잘못된 접근입니다.',
                  style: AppTheme.body1.copyWith(
                    color: AppColors.borderError,
                  ),
                ),
              ),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 250),
          );
        }
        return CustomTransitionPage(
          key: state.pageKey,
          child: SentenceEdit(
            sentenceId: args['sentenceId'] as int,
            initialContent: args['initialContent'] as String,
            isPublic: args['isPublic'] as bool,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 250),
        );
      },
    ),
  ];
}
