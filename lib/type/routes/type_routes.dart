import 'package:go_router/go_router.dart';
import 'package:typed/type/screens/my_type.dart';

class TypeRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/type',
      builder: (context, state) => const MyType(),
    ),
  ];
}
