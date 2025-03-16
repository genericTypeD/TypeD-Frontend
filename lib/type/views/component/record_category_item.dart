import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/routes/type_routes.dart';

class RecordCategoryItem {
  final IconData icon;
  final String label;
  final GridItemType type;

  const RecordCategoryItem({
    required this.icon,
    required this.label,
    required this.type,
  });

  String get routeName => TypeRoutes.getRouteNameByType(type);
  String get path => TypeRoutes.getPathByType(type);

  // 네비게이션 메소드
  void navigate(BuildContext context, {GridItem? item}) {
    context.goNamed(
      routeName,
      extra: item != null ? {'item': item} : null,
    );
  }

  static List<RecordCategoryItem> get allCategories => [
        RecordCategoryItem(
          icon: Icons.subject,
          label: '문장',
          type: GridItemType.sentence,
        ),
        RecordCategoryItem(
          icon: Icons.book,
          label: '책',
          type: GridItemType.bookReview,
        ),
        RecordCategoryItem(
          icon: Icons.music_note,
          label: '음악',
          type: GridItemType.music,
        ),
        RecordCategoryItem(
          icon: Icons.movie,
          label: '이미지',
          type: GridItemType.image,
        ),
      ];
}
