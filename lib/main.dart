/*import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed/sentence_collection/screens/empty_page.dart';
import 'package:typed/sentence_collection/screens/sentence_list_page.dart';
import 'package:typed/sentence_collection/state/sentence_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SentenceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<SentenceProvider>(
        builder: (context, provider, child) {
          // 문장이 없으면 empty_page.dart, 있으면 sentence_list_page.dart로 전환
          return provider.sentences.isEmpty ? EmptyPage() : SentenceListPage();
        },
      ),
    );
  }
}
