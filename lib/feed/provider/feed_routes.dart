import 'package:go_router/go_router.dart';
import 'package:typed/feed/component/error_screen.dart';
import 'package:typed/feed/model/feed_model.dart';
import 'package:typed/feed/screen/feed_bookmark.dart';
import 'package:typed/feed/screen/feed_detail.dart';
// import 'package:typed/feed/screen/feed_edit.dart';
// import 'package:typed/feed/screen/feed_empty.dart';
import 'package:typed/feed/screen/feed_public.dart';
import 'package:typed/feed/screen/feed_search.dart';

class FeedRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/feed_public',
      builder: (context, state) => const FeedPublic(),
    ),
    // GoRoute(
    //   path: '/feed_edit',
    //   builder: (context, state) => const FeedEdit(),
    // ),
    GoRoute(
      path: '/feed_search',
      builder: (context, state) => const FeedSearch(),
    ),
    GoRoute(
      path: '/feed_bookmark',
      builder: (context, state) => const FeedBookmark(),
    ),
    // GoRoute(
    //   path: '/feed_empty',
    //   builder: (context, state) => const FeedEmpty(),
    // ),
    GoRoute(
      path: '/feed_detail',
      builder: (context, state) {
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;

        if (data == null) {
          return const ErrorScreen(message: "데이터가 존재하지 않습니다.");
        }

        final feed = FeedModel.fromJson(data);
        return FeedDetail(feed: feed);
      },
    ),
    GoRoute(
      path: '/feed_detail',
      builder: (context, state) {
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;

        if (data == null) {
          return const ErrorScreen(message: "데이터가 존재하지 않습니다.");
        }

        final feed = FeedModel.fromJson(data);
        return FeedDetail(feed: feed);
      },
    ),
  ];
}
