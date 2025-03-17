import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/provider/app_routes.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:typed/type/models/grid_data.dart';
import 'package:typed/type/models/split_view_data.dart';

void main() async {
  // Flutter 바인딩 초기화 추가
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load(fileName: ".env");

  // TODO: - core에 별도의 객체, 함수로 분리 (반환 타입: Future<void>)
  // Hive 초기화
  await Hive.initFlutter();

  // TypeAdaptors 등록
  Hive.registerAdapter(ReviewAdapter());
  Hive.registerAdapter(SentenceAdapter());
  Hive.registerAdapter(SplitViewDataAdapter());
  Hive.registerAdapter(GridDataAdapter());

  // Hive Box 열기
  await Hive.openBox<Review>('review');
  await Hive.openBox<Sentence>('sentence');
  await Hive.openBox<SplitViewData>('split_view');
  await Hive.openBox<GridData>('grid');

  // 한국어 로컬 포맷팅 초기화
  await initializeDateFormatting('ko', null);

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
        scaffoldBackgroundColor: AppColors.backgroundSecondary,
      ),
    );
  }
}
