import 'package:go_router/go_router.dart';
import 'package:typed/feed/screen/feed_list.dart';

class FeedRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/feed',
      builder: (context, state) => const FeedList(),
    ),
  ];
}
