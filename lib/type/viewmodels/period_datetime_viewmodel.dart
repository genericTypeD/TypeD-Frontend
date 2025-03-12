import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/type/models/period_type.dart';

class PeriodDateTimeState {
  final PeriodType periodType;
  final DateTime dateTime;

  PeriodDateTimeState({
    required this.periodType,
    required this.dateTime,
  });

  factory PeriodDateTimeState.initial() {
    return PeriodDateTimeState(
      periodType: PeriodType.daily,
      dateTime: DateTime.now(),
    );
  }

  PeriodDateTimeState copyWith({
    PeriodType? periodType,
    DateTime? dateTime,
  }) {
    return PeriodDateTimeState(
      periodType: periodType ?? this.periodType,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

class PeriodDateNotifier extends StateNotifier<PeriodDateTimeState> {
  PeriodDateNotifier() : super(PeriodDateTimeState.initial());

  void updatePeriodType(PeriodType periodType) {
    state = state.copyWith(periodType: periodType);
  }

  void updateDateTime(DateTime dateTime) {
    state = state.copyWith(dateTime: dateTime);
  }

  void updatePeriodAndDate(PeriodType periodType, DateTime dateTime) {
    state = PeriodDateTimeState(
      periodType: periodType,
      dateTime: dateTime,
    );
  }
}

final periodDateProvider =
    StateNotifierProvider<PeriodDateNotifier, PeriodDateTimeState>((ref) {
  return PeriodDateNotifier();
});
