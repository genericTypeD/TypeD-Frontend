import 'package:flutter/material.dart';
import 'package:typed/sentence/screen/sentence_edit.dart';
import 'package:typed/sentence/screen/sentence_empty.dart';
import 'package:typed/sentence/screen/sentence_input.dart';
import 'package:typed/sentence/screen/sentence_list.dart';

class SentenceRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sentence_input':
        return MaterialPageRoute(builder: (_) => SentenceInput());
      case '/sentence_list':
        return MaterialPageRoute(builder: (_) => SentenceList());
      case '/sentence_empty':
        return MaterialPageRoute(builder: (_) => SentenceEmpty());
      case '/sentence_edit':
        return MaterialPageRoute(builder: (_) => SentenceEdit());
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
