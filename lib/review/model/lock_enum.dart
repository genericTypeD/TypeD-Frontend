enum LockStatus {
  closed,
  open;

  String get korName => this == LockStatus.closed ? '비공개' : '공개';
}
