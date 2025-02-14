import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typed/common/provider/app_routes.dart';
import 'package:typed/common/screen/splash.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // 초기 화면: SplashScreen
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
