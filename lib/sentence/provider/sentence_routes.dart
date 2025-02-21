import 'package:go_router/go_router.dart';
import 'package:typed/sentence/screen/sentence_edit.dart';
import 'package:typed/sentence/screen/sentence_empty.dart';
import 'package:typed/sentence/screen/sentence_input.dart';
import 'package:typed/sentence/screen/sentence_list.dart';

class SentenceRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/sentence_input',
      builder: (context, state) => const SentenceInput(),
    ),
    GoRoute(
      path: '/sentence_list',
      builder: (context, state) => const SentenceList(),
    ),
    GoRoute(
      path: '/sentence_empty',
      builder: (context, state) => const SentenceEmpty(),
    ),
    GoRoute(
      path: '/sentence_edit',
      builder: (context, state) => const SentenceEdit(),
    ),
  ];
}
