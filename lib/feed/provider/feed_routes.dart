import 'package:flutter/material.dart';
import 'package:typed/feed/screen/feed_list.dart';

class FeedRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/feed':
        return MaterialPageRoute(builder: (_) => FeedListPage());
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
