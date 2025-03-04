enum GridItemType {
  sentence,
  book,
  music,
  image,
  empty;

  static List<GridItemType> get allTypes => [
        empty,
        sentence,
        book,
        music,
        image,
      ];

  static List<GridItemType> get contentTypes => [
        sentence,
        book,
        music,
        image,
      ];
}
