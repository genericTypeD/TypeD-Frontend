enum GridItemType {
  sentence,
  bookReview,
  music,
  image,
  empty;

  static List<GridItemType> get allTypes => [
        empty,
        sentence,
        bookReview,
        music,
        image,
      ];

  static List<GridItemType> get contentTypes => [
        sentence,
        bookReview,
        music,
        image,
      ];
}
