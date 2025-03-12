import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/review/screen/review_edit_screen.dart';
import 'package:typed/review/screen/review_input_screen.dart';
import 'package:typed/review/screen/book_search_screen.dart';
import 'package:typed/review/screen/review_list_screen.dart';

class ReviewRoutes {
  static final List<GoRoute> routes = [
    /// 책 검색 화면
    GoRoute(
      path: '/book_search',
      builder: (context, state) => const BookSearchScreen(),
    ),

    /// 서평 작성 화면
    GoRoute(
      path: '/review_input',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ReviewInputScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    ),

    /// 서평 목록 화면
    GoRoute(
      path: '/review_list',
      builder: (context, state) => const ReviewListScreen(),
    ),

    /// 서평 수정 화면
    GoRoute(
      path: '/review_edit',
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        if (args == null) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: DefaultLayout(
              backgroundColor: AppColors.backgroundSecondary,
              appBar: CustomAppBar(
                bottomLeftWidget: Text(
                  'error',
                  textAlign: TextAlign.left,
                  style: AppTheme.title3,
                ),
              ),
              child: Center(
                child: Text(
                  '잘못된 접근입니다.',
                  style: AppTheme.title3,
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
          child: ReviewEditScreen(
            reviewId: args['reviewId'] as int,
            initialContent: args['initialContent'] as String,
            isPublic: args['isPublic'] as bool,
            bookTitle: args['bookTitle'] as String,
            thumbnail: args['thumbnail'] as String?,
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
