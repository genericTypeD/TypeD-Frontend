import 'package:flutter/material.dart';
import 'package:typed/type/screen/my_type.dart';

class TypeRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/type':
        return MaterialPageRoute(builder: (_) => const MyType());
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
