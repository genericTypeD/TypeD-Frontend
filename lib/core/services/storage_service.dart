import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:typed/type/models/grid_data.dart';
import 'package:typed/type/models/split_view_data.dart';

class StorageService {
  static const String reviewBoxName = 'review';
  static const String sentenceBoxName = 'sentence';
  static const String splitViewBoxName = 'split_view';
  static const String gridBoxName = 'grid';

  static final List<String> allBoxes = [
    reviewBoxName,
    sentenceBoxName,
    splitViewBoxName,
    gridBoxName,
  ];

  /// Hive 초기화
  static Future<void> initialize() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openBoxes();
  }

  /// Hive 어댑터 등록
  static void _registerAdapters() {
    Hive.registerAdapter(ReviewAdapter());
    Hive.registerAdapter(SentenceAdapter());
    Hive.registerAdapter(SplitViewDataAdapter());
    Hive.registerAdapter(GridDataAdapter());
  }

  /// 필요한 박스 열기
  static Future<void> _openBoxes() async {
    await Hive.openBox<Review>(reviewBoxName);
    await Hive.openBox<Sentence>(sentenceBoxName);
    await Hive.openBox<SplitViewData>(splitViewBoxName);
    await Hive.openBox<GridData>(gridBoxName);
  }

  /// 모든 박스 데이터 초기화
  static Future<void> clearAllData() async {
    try {
      await Hive.box<Review>('review').clear();
      await Hive.box<Sentence>('sentence').clear();
      await Hive.box<SplitViewData>('split_view').clear();
      await Hive.box<GridData>('grid').clear();

      debugPrint('모든 데이터가 삭제되었습니다.');
    } catch (e) {
      debugPrint('데이터 삭제 중 오류가 발생했습니다. ($e)');
    }
  }

  /// Hive 종료 (앱 종료시 호출)
  static Future<void> closeHive() async {
    await Hive.close();
  }
}
