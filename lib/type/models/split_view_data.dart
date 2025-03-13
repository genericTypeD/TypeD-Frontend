import 'package:hive/hive.dart';
import 'package:typed/type/models/period_type.dart';
import 'package:typed/type/utils/date_formatter.dart';

part 'split_view_data.g.dart';

@HiveType(typeId: 4)
class SplitViewData extends HiveObject {
  @HiveField(0)
  final String periodTypeStr;

  @HiveField(1)
  final DateTime dateTime;

  @HiveField(2)
  final List<List<double>> horizontalFlexValues;

  @HiveField(3)
  final List<double> verticalFlexValues;

  SplitViewData({
    required this.periodTypeStr,
    required this.dateTime,
    required this.horizontalFlexValues,
    required this.verticalFlexValues,
  });

  /// PeriodType을 문자열로 변환해서 저장하는 팩토리 생성자
  factory SplitViewData.fromState(
    PeriodType periodType,
    DateTime dateTime,
    List<List<double>> horizontalFlexValues,
    List<double> verticalFlexValues,
  ) {
    return SplitViewData(
      periodTypeStr: periodType.name,
      dateTime: dateTime,
      horizontalFlexValues: horizontalFlexValues,
      verticalFlexValues: verticalFlexValues,
    );
  }

  /// 저장용 키 생성 메소드 (PeriodType과 날짜를 조합해서 고유 키 생성)
  static String createKey(PeriodType periodType, DateTime dateTime) {
    switch (periodType) {
      // 1. 일간 모드: periodType + 년 + 월 + 일
      case PeriodType.daily:
        final dateStr =
            '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
        return 'split_${periodType.name}_$dateStr';

      // 2. 주간 모드: periodType + 해당 주의 월요일
      case PeriodType.weekly:
        final firstDayOfWeek = DateFormatter.getFirstDayOfWeek(dateTime);
        final weekDateStr =
            '${firstDayOfWeek.year}-${firstDayOfWeek.month.toString().padLeft(2, '0')}-${firstDayOfWeek.day.toString().padLeft(2, '0')}';
        return 'split_${periodType.name}_$weekDateStr';

      // 3. 월간 모드: periodType + 년 + 월
      case PeriodType.monthly:
        final monthStr =
            '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}';
        return 'split_${periodType.name}_$monthStr';

      // 4. 연간 모드: periodType + 연도
      case PeriodType.yearly:
        return 'split_${periodType.name}_${dateTime.year}';
    }
  }
}
