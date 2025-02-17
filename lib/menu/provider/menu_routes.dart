import 'package:flutter/material.dart';
import 'package:typed/menu/screen/my_menu.dart';

class MenuRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/menu':
        return MaterialPageRoute(builder: (_) => MyMenu());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
