import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/views/my_book_record_screen.dart';
import 'package:typed/type/views/my_image_record_screen.dart';
import 'package:typed/type/views/my_music_record_screen.dart';
import 'package:typed/type/views/my_sentence_record_screen.dart';
import 'package:typed/type/views/my_type.dart';

class RecordScreensRouter {
  static GridItem? castGridItem(Object? item) {
    if (item is GridItem?) {
      return item;
    } else {
      return null;
    }
  }

  static Widget createSentenceRecordScreen(GoRouterState state) {
    final gridItem = castGridItem(state.extra);
    return MySentenceRecordScreen(item: gridItem);
  }

  static Widget createBookRecordScreen(GoRouterState state) {
    final gridItem = castGridItem(state.extra);
    return MyBookRecordScreen(item: gridItem);
  }

  static Widget createMusicRecordScreen(GoRouterState state) {
    final gridItem = castGridItem(state.extra);
    return MyMusicRecordScreen(item: gridItem);
  }

  static Widget createImageRecordScreen(GoRouterState state) {
    final gridItem = castGridItem(state.extra);
    return MyImageRecordScreen(item: gridItem);
  }
}

class TypeRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/type',
      builder: (context, state) => const MyType(),
    ),
  ];
}
