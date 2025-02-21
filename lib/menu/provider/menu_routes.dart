import 'package:go_router/go_router.dart';
import 'package:typed/menu/screen/my_menu.dart';

class MenuRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/menu',
      builder: (context, state) => const MyMenu(),
    ),
  ];
}
