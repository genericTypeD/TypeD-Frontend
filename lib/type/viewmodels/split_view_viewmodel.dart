import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:typed/type/models/period_type.dart';
import 'package:typed/type/models/split_view_data.dart';
import 'package:typed/type/models/split_view_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final splitViewProvider =
    StateNotifierProvider<SplitViewViewModel, SplitViewState>((ref) {
  return SplitViewViewModel();
});

class SplitViewViewModel extends StateNotifier<SplitViewState> {
  SplitViewViewModel() : super(SplitViewState.initial()) {
    _loadFlex();
  }

  PeriodType _currentPeriodType = PeriodType.weekly; // 현재 선택된 PeriodType
  DateTime _currentDateTime = DateTime.now(); // 현재 선택된 날짜

  Future<void> loadForPeriodAndDate(
      PeriodType periodType, DateTime dateTime) async {
    debugPrint('[로드 시도] periodType: ${periodType.name}, dateTime: $dateTime');

    _currentPeriodType = periodType;
    _currentDateTime = dateTime;

    await _loadFromHive(); // Hive에서 데이터 로드
  }

  Future<void> _loadFromHive() async {
    try {
      final box = Hive.box<SplitViewData>('split_view'); // SplitView 전용 박스 열고

      final key = SplitViewData.createKey(
          _currentPeriodType, _currentDateTime); // 로드할 키 생성
      debugPrint('로드 키 생성: $_currentPeriodType / $_currentDateTime => $key');

      final data = box.get(key); // 박스에서 데이터 로드 후,

      if (data != null) {
        // 로드된 데이터로 상태 업데이트
        state = SplitViewState(
          horizontalFlexValues: data.horizontalFlexValues,
          verticalFlexValues: data.verticalFlexValues,
        );
        debugPrint('[SplitView 데이터 로드 완료] key: $key');
      } else {
        // 해당 기간/날짜의 데이터가 없으면 기본값 사용
        state = SplitViewState.initial();
        debugPrint('[SplitView 기본 데이터 사용해서 로드 완료]: $key');
      }
    } catch (error) {
      // 오류 발생 시에도 기본값 사용
      state = SplitViewState.initial();
      debugPrint('[SplitView 데이터 로드 실패] error: $error');
    }
  }

  Future<void> _loadFlex() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedVerticalFlex = prefs.getStringList('vertical_flex');
      final List<List<double>> horizontalFlex = [];
      for (var i = 0; i < 3; i++) {
        final savedHorizontalFlex = prefs.getStringList('horizontal_flex_$i');
        if (savedHorizontalFlex != null) {
          horizontalFlex
              .add(savedHorizontalFlex.map((s) => double.parse(s)).toList());
        }
      }

      if (savedVerticalFlex != null && horizontalFlex.length == 3) {
        state = SplitViewState(
          verticalFlexValues:
              savedVerticalFlex.map((s) => double.parse(s)).toList(),
          horizontalFlexValues: horizontalFlex,
        );
      }
    } catch (error) {
      debugPrint('[Flex 로딩 실패] $error');
    }
  }

  Future<void> updateVerticalFlex(List<double> flexValues) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'vertical_flex',
        flexValues.map((f) => f.toString()).toList(),
      );

      state = SplitViewState(
        horizontalFlexValues: state.horizontalFlexValues,
        verticalFlexValues: flexValues,
      );
    } catch (error) {
      debugPrint('[Vertical Flex 업데이트 실패] $error');
    }
  }

  Future<void> updateHorizontalFlex(int index, List<double> flexValues) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'horizontal_flex_$index',
        flexValues.map((f) => f.toString()).toList(),
      );

      final newHorizontalFlex =
          List<List<double>>.from(state.horizontalFlexValues);
      newHorizontalFlex[index] = flexValues;

      state = SplitViewState(
        horizontalFlexValues: newHorizontalFlex,
        verticalFlexValues: state.verticalFlexValues,
      );
    } catch (error) {
      debugPrint('[Horizontal Flex 저장 실패] $error');
    }
  }
}
