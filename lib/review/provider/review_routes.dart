import 'package:go_router/go_router.dart';
import 'package:typed/review/screen/review_empty.dart';

class ReviewRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/review',
      builder: (context, state) => const ReviewEmpty(),
    ),
  ];
}
