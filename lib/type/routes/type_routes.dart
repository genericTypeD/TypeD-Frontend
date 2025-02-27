// import 'package:flutter/material.dart';
// import 'package:typed/type/screen/my_type.dart';
//
// class TypeRoutes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/type':
//         return MaterialPageRoute(builder: (_) => const MyType());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }

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
