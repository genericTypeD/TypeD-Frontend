import 'package:flutter/material.dart';
import 'package:typed/common/screen/home_tab.dart'; // TypeRoutes 임포트
import 'package:typed/feed/provider/feed_routes.dart'; // FeedRoutes 임포트
import 'package:typed/menu/provider/menu_routes.dart'; // MenuRoutes 임포트
import 'package:typed/review/provider/review_routes.dart';
import 'package:typed/sentence/provider/sentence_routes.dart'; // SentenceRoutes 임포트
import 'package:typed/type/provider/type_routes.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // 타입 관련 라우팅은 TypeRoutes에서 처리
    if (settings.name?.startsWith('/type') == true) {
      return TypeRoutes.generateRoute(settings);
    }

    if (settings.name?.startsWith('/review') == true) {
      return ReviewRoutes.generateRoute(settings);
    }

    if (settings.name?.startsWith('/sentence') == true) {
      return SentenceRoutes.generateRoute(settings);
    }

    if (settings.name?.startsWith('/feed') == true) {
      return FeedRoutes.generateRoute(settings);
    }

    if (settings.name?.startsWith('/menu') == true) {
      return MenuRoutes.generateRoute(settings);
    }

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeTab());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
