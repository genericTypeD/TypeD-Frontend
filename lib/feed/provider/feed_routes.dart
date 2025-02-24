import 'package:go_router/go_router.dart';
import 'package:typed/feed/screen/feed_edit.dart';
import 'package:typed/feed/screen/feed_list.dart';
import 'package:typed/feed/screen/feed_public.dart';

class FeedRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/feed_public',
      builder: (context, state) => const FeedPublic(),
    ),
    GoRoute(
      path: '/feed_list',
      builder: (context, state) => const FeedList(),
    ),
    GoRoute(
      path: '/feed_edit',
      builder: (context, state) => const FeedEdit(),
    ),
  ];
}
