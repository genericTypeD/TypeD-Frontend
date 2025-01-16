import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/screen/home_tab.dart'; // HomeTab 임포트
import 'package:typed/feed/screen/feed_list.dart';
import 'package:typed/menu/screen/my_menu.dart';
import 'package:typed/review/screen/review_empty.dart';
import 'package:typed/sentence/provider/sentence_routes.dart'; // SentenceRoutes 임포트
import 'package:typed/type/screen/my_type.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // 문장 관련 라우팅은 SentenceRoutes에서 처리
    if (settings.name?.startsWith('/sentence') == true) {
      return SentenceRoutes.generateRoute(settings);
    }

    String title = '';
    Widget child;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomeTab(), // HomeTab으로 직접 라우팅
        );

      case '/my_type':
        title = 'My Type';
        child = MyType();
        break;
      case '/review':
        title = '서평 메모';
        child = ReviewEmpty();
        break;
      case '/feed':
        title = 'Feed';
        child = FeedListPage();
        break;
      case '/menu':
        title = '나의 메뉴';
        child = MyMenu();
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }

    return MaterialPageRoute(
      builder: (context) => DefaultLayout(
        title: title,
        child: child,
        bottomNavigationBar: null, // 내비게이션 바는 HomeTab에서만 관리
      ),
    );
  }
}
