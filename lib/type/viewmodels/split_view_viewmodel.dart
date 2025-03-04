import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    } catch (e) {
      debugPrint('[Loading Flex Error] $e');
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
    } catch (e) {
      debugPrint('[Updating Vertical Flex Error] $e');
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
    } catch (e) {
      debugPrint('[Saving Horizontal Flex Error] $e');
    }
  }
}
