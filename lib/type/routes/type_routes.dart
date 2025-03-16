import 'package:go_router/go_router.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/routes/record_screens_router.dart';
import 'package:typed/type/views/my_type.dart';

class TypeRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/type',
      name: 'my-type',
      builder: (context, state) => const MyType(),
      routes: [
        GoRoute(
          path: 'sentence',
          name: 'sentence-record',
          builder: (context, state) {
            return RecordScreensRouter.createSentenceRecordScreen(state);
          },
        ),
        GoRoute(
          path: 'book',
          name: 'book-record',
          builder: (context, state) {
            return RecordScreensRouter.createBookRecordScreen(state);
          },
        ),
        GoRoute(
          path: 'music',
          name: 'music-record',
          builder: (context, state) {
            return RecordScreensRouter.createMusicRecordScreen(state);
          },
        ),
        GoRoute(
          path: 'image',
          name: 'image-record',
          builder: (context, state) {
            return RecordScreensRouter.createImageRecordScreen(state);
          },
        ),
      ],
    ),
  ];

  // GridItem의 type에 따른 라우트 이름을 반환하는 유틸리티 메소드
  static String getRouteNameByType(GridItemType type) {
    switch (type) {
      case GridItemType.sentence:
        return 'sentence-record';
      case GridItemType.bookReview:
        return 'book-record';
      case GridItemType.music:
        return 'music-record';
      case GridItemType.image:
        return 'image-record';
      default:
        return 'my-type';
    }
  }

  // GridItem의 type에 따른 전체 경로를 반환하는 유틸리티 메소드
  static String getPathByType(GridItemType type) {
    switch (type) {
      case GridItemType.sentence:
        return '/type/sentence';
      case GridItemType.bookReview:
        return '/type/book';
      case GridItemType.music:
        return '/type/music';
      case GridItemType.image:
        return '/type/image';
      default:
        return '/type';
    }
  }
}
