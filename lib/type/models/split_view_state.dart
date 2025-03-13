class SplitViewState {
  final List<List<double>> horizontalFlexValues;
  final List<double> verticalFlexValues;
  SplitViewState({
    required this.horizontalFlexValues,
    required this.verticalFlexValues,
  });

  factory SplitViewState.initial() {
    return SplitViewState(
      horizontalFlexValues: List.generate(3, (_) => [1.0, 1.0]),
      verticalFlexValues: List.generate(3, (_) => 1.0),
    );
  }

  SplitViewState copyWith({
    List<List<double>>? horizontalFlexValues,
    List<double>? verticalFlexValues,
  }) {
    return SplitViewState(
      horizontalFlexValues: horizontalFlexValues ?? this.horizontalFlexValues,
      verticalFlexValues: verticalFlexValues ?? this.verticalFlexValues,
    );
  }
}
