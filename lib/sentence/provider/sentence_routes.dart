import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/sentence/screen/sentence_edit.dart';
import 'package:typed/sentence/screen/sentence_empty.dart';
import 'package:typed/sentence/screen/sentence_input.dart';
import 'package:typed/sentence/screen/sentence_list.dart';

class SentenceRoutes {
  static final List<GoRoute> routes = [
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
    GoRoute(
      path: '/sentence_list',
      builder: (context, state) => const SentenceList(),
    ),
    GoRoute(
      path: '/sentence_empty',
      builder: (context, state) => const SentenceEmpty(),
    ),
    GoRoute(
      path: '/sentence_edit',
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        if (args == null) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: DefaultLayout(
              appBar: AppBar(title: const Text("오류")),
              child: const Center(
                child: Text(
                  "잘못된 접근입니다.",
                  style: TextStyle(color: Colors.red, fontSize: 18),
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
