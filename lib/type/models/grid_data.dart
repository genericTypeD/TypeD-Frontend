import 'package:hive_flutter/hive_flutter.dart';
import 'package:typed/type/models/period_type.dart';
import 'package:typed/type/utils/date_formatter.dart';

part 'grid_data.g.dart';

@HiveType(typeId: 5)
class GridData extends HiveObject {
  @HiveField(0)
  final String periodTypeStr;

  @HiveField(1)
  final DateTime dateTime;

  @HiveField(2)
  final List<List<Map<String, dynamic>>> gridItemsJson;

  GridData({
    required this.periodTypeStr,
    required this.dateTime,
    required this.gridItemsJson,
  });

  static String createKey(PeriodType periodType, DateTime dateTime) {
    switch (periodType) {
      // 1. 일간 모드: 년-월-일 형식으로 키 생성
      case PeriodType.daily:
        final dateStr =
            '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
        return 'grid_${periodType.name}_$dateStr';

      // 2. 주간 모드: 해당 주의 월요일을 기준으로 키 생성
      case PeriodType.weekly:
        final firstDayOfWeek = DateFormatter.getFirstDayOfWeek(dateTime);
        final weekDateStr =
            '${firstDayOfWeek.year}-${firstDayOfWeek.month.toString().padLeft(2, '0')}-${firstDayOfWeek.day.toString().padLeft(2, '0')}';
        return 'grid_${periodType.name}_$weekDateStr';

      // 3. 월간 모드: 년-월 형식으로 키 생성
      case PeriodType.monthly:
        final monthStr =
            '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}';
        return 'grid_${periodType.name}_$monthStr';

      // 4. 연간 모드: 연도만 키 생성 사용
      case PeriodType.yearly:
        return 'grid_${periodType.name}_${dateTime.year}';
    }
  }
}
