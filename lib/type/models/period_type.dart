enum PeriodType {
  daily('daily', '오늘의 나'),
  weekly('weekly', '이주의 나'),
  monthly('monthly', '이달의 나'),
  yearly('yearly', '올해의 나');

  const PeriodType(this.engName, this.korName);

  final String engName;
  final String korName;

  String getEngName() {
    return engName;
  }

  String getKorName() {
    return korName;
  }

  static List<PeriodType> get allCases => PeriodType.values;

  static List<String> get allEngNames =>
      PeriodType.values.map((type) => type.engName).toList();

  static List<String> get allKorNames =>
      PeriodType.values.map((type) => type.korName).toList();
}
