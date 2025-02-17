import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:typed/common/provider/app_routes.dart'; // AppRoutes 임포트
import 'package:typed/common/screen/splash.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    as riverpod; // riverpod으로 변경

void main() {
  runApp(
    riverpod.ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(create: (_) => SentenceProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // 초기 화면: SplashScreen
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
