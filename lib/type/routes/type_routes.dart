import 'package:go_router/go_router.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/routes/record_screens_router.dart';
import 'package:typed/type/routes/type_routes_utils.dart';
import 'package:typed/type/views/my_type.dart';

class TypeRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: RoutePaths.base,
      name: RouteNames.myType,
      builder: (context, state) => const MyType(),
      routes: [
        GoRoute(
          path: RoutePaths.sentence,
          name: RouteNames.sentenceRecord,
          builder: (context, state) {
            return RecordScreensRouter.createSentenceRecordScreen(state);
          },
        ),
        GoRoute(
          path: RoutePaths.book,
          name: RouteNames.bookRecord,
          builder: (context, state) {
            return RecordScreensRouter.createBookRecordScreen(state);
          },
        ),
        GoRoute(
          path: RoutePaths.music,
          name: RouteNames.musicRecord,
          builder: (context, state) {
            return RecordScreensRouter.createMusicRecordScreen(state);
          },
        ),
        GoRoute(
          path: RoutePaths.image,
          name: RouteNames.imageRecord,
          builder: (context, state) {
            return RecordScreensRouter.createImageRecordScreen(state);
          },
        ),
      ],
    ),
  ];

  /// GridItem의 type에 따른 라우트 이름을 반환하는 유틸리티 메소드
  static String getRouteNameByType(GridItemType type) {
    switch (type) {
      case GridItemType.sentence:
        return RouteNames.sentenceRecord;
      case GridItemType.bookReview:
        return RouteNames.bookRecord;
      case GridItemType.music:
        return RouteNames.musicRecord;
      case GridItemType.image:
        return RouteNames.imageRecord;
      default:
        return RouteNames.myType;
    }
  }

  /// GridItem의 type에 따른 전체 경로를 반환하는 유틸리티 메소드
  static String getPathByType(GridItemType type) {
    switch (type) {
      case GridItemType.sentence:
        return RoutePaths.sentence;
      case GridItemType.bookReview:
        return RoutePaths.book;
      case GridItemType.music:
        return RoutePaths.music;
      case GridItemType.image:
        return RoutePaths.image;
      default:
        return RoutePaths.base;
    }
  }
}
