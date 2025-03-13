import 'package:go_router/go_router.dart';
import 'package:typed/common/screen/home_tab.dart';
import 'package:typed/common/screen/splash.dart';
import 'package:typed/feed/provider/feed_routes.dart';
import 'package:typed/feed/screen/feed_public.dart';
import 'package:typed/review/ui/screens/book_search_screen.dart';
import 'package:typed/review/provider/review_routes.dart';
import 'package:typed/review/ui/screens/review_list_screen.dart';
import 'package:typed/sentence/provider/sentence_routes.dart';
import 'package:typed/sentence/screen/sentence_list.dart';
import 'package:typed/type/routes/type_routes.dart';
import 'package:typed/type/views/my_type.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeTab(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home/type',
              name: 'mytype_tab',
              builder: (context, state) => const MyType(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home/review',
              name: 'review_tab',
              builder: (context, state) => const ReviewListScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home/book_search',
              name: 'book_search_tab',
              builder: (context, state) => const BookSearchScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home/sentence_list',
              name: 'sentence_tab',
              builder: (context, state) => const SentenceList(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home/feed',
              name: 'feed_tab',
              builder: (context, state) => const FeedPublic(),
            ),
          ]),
        ],
      ),
      ...TypeRoutes.routes,
      ...ReviewRoutes.routes,
      ...SentenceRoutes.routes,
      ...FeedRoutes.routes,
    ],
  );
}
