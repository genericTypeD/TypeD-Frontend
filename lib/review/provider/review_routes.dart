// import 'package:flutter/material.dart';
//
// import 'screen/note_page_1.dart';
// import 'screen/note_page_2.dart';
//
// class SentenceNoteRoutes {
//   static const String notePage1 = '/note_page_1';
//   static const String notePage2 = '/note_page_2';
//
//   static final Map<String, WidgetBuilder> routes = {
//     notePage1: (_) => NotePage1(),
//     notePage2: (_) => NotePage2(),
//   };
// }

import 'package:flutter/material.dart';
import 'package:typed/review/screen/review_empty.dart';

class ReviewRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/review':
        return MaterialPageRoute(builder: (_) => ReviewEmpty());
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
