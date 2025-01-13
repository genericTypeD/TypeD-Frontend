import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed/common/screen/home_tab.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SentenceProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeTab(),
    );
  }
}
