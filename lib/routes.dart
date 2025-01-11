import 'package:flutter/material.dart';

import 'sentence_collection/screens/empty_page.dart';
import 'sentence_collection/screens/sentence_list_page.dart';

class AppRoutes {
  static const String emptyPage = '/';
  static const String sentenceList = '/sentence-list';

  static final Map<String, WidgetBuilder> routes = {
    emptyPage: (_) => EmptyPage(),
    sentenceList: (_) => SentenceListPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (routes.containsKey(settings.name)) {
      return MaterialPageRoute(builder: routes[settings.name]!);
    }
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
    );
  }
}
