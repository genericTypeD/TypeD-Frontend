import 'package:go_router/go_router.dart';
import 'package:typed/review/screen/review_edit.dart';
import 'package:typed/review/screen/review_empty.dart';
import 'package:typed/review/screen/review_input.dart';
import 'package:typed/review/screen/review_list.dart';

class SentenceRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/review_input',
      builder: (context, state) => const ReviewInput(),
    ),
    GoRoute(
      path: '/review_list',
      builder: (context, state) => const ReviewList(),
    ),
    GoRoute(
      path: '/review_empty',
      builder: (context, state) => const ReviewEmpty(),
    ),
    GoRoute(
      path: '/review_edit',
      builder: (context, state) => const ReviewEdit(),
    ),
  ];
}
