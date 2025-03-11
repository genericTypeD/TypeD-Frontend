import 'package:intl/intl.dart';
import 'package:typed/type/models/period_type.dart';

class DateFormatter {
  /// PeriodType에 따라 적절한 날짜 형식을 반환하는 메소드
  static String formatByPeriodType(PeriodType periodType, DateTime dateTime,
      {String locale = 'ko'}) {
    switch (periodType) {
      // 1. 일간 모드: 년 + 월 + 일 + 요일 표시
      case PeriodType.daily:
        return DateFormat('y년 M월 d일 EEEE', locale).format(dateTime);

      // 2. 주간 모드: 월 + 몇째주 표시 (ex. 3월 첫째주)
      case PeriodType.weekly:
        final firstDayOfWeek = _getFirstDayOfWeek(dateTime);
        final weekOfMonth = (firstDayOfWeek.day / 7).ceil();
        final weekNames = ['첫째', '둘째', '셋째', '넷째', '다섯째'];
        final weekName = weekOfMonth <= weekNames.length
            ? weekNames[weekOfMonth - 1]
            : '$weekOfMonth번째';

        return '${firstDayOfWeek.year}년 ${firstDayOfWeek.month}월 $weekName주';

      // 3. 월간 모드: 년 + 월 표시 (ex. 2025년 3월)
      case PeriodType.monthly:
        return DateFormat('y년 M월', locale).format(dateTime);

      // 4. 연간 모드: 연도만 표시 (ex. 2025년)
      case PeriodType.yearly:
        return DateFormat('y년', locale).format(dateTime);
    }
  }

  /// 한 주의 월요일을 구하는 헬퍼 메소드
  static DateTime _getFirstDayOfWeek(DateTime date) {
    final difference = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: difference));
  }
}
