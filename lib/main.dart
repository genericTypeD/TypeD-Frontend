import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:typed/common/provider/app_routes.dart'; // AppRoutes 임포트
import 'package:typed/common/screen/splash.dart';
import 'package:typed/sentence/provider/sentence_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ 앱 실행 시 한 번만 설정
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

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
      home: const SplashScreen(), // 초기 화면: SplashScreen
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
