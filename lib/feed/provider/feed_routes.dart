import 'package:go_router/go_router.dart';
import 'package:typed/feed/screen/feed_bookmark.dart';
import 'package:typed/feed/screen/feed_edit.dart';
import 'package:typed/feed/screen/feed_empty.dart';
import 'package:typed/feed/screen/feed_list.dart';
import 'package:typed/feed/screen/feed_public.dart';
import 'package:typed/feed/screen/feed_search.dart';

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
    GoRoute(
      path: '/feed_search',
      builder: (context, state) => const FeedSearch(),
    ),
    GoRoute(
      path: '/feed_bookmark',
      builder: (context, state) => const FeedBookmark(),
    ),
    GoRoute(
      path: '/feed_empty',
      builder: (context, state) => const FeedEmpty(),
    ),
  ];
}
