class BookSearchResult {
  final List<Book> documents;
  final Meta meta;

  BookSearchResult({
    required this.documents,
    required this.meta,
  });

  factory BookSearchResult.fromJson(Map<String, dynamic> json) {
    return BookSearchResult(
      documents:
          (json['documents'] as List).map((doc) => Book.fromJson(doc)).toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Book {
  final List<String> authors;
  final String contents;
  final DateTime datetime;
  final String isbn;
  final int price;
  final String publisher;
  final int salePrice;
  final String status;
  final String thumbnail;
  final String title;
  final List<String> translators;
  final String url;

  Book({
    required this.authors,
    required this.contents,
    required this.datetime,
    required this.isbn,
    required this.price,
    required this.publisher,
    required this.salePrice,
    required this.status,
    required this.thumbnail,
    required this.title,
    required this.translators,
    required this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      authors: List<String>.from(json['authors']),
      contents: json['contents'] ?? '',
      datetime: DateTime.parse(json['datetime']),
      isbn: json['isbn'] ?? '',
      price: json['price'] ?? -1,
      publisher: json['publisher'] ?? '',
      salePrice: json['sale_price'] ?? -1,
      status: json['status'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      title: json['title'] ?? '',
      translators: List<String>.from(json['translators']),
      url: json['url'] ?? '',
    );
  }
}

class Meta {
  final bool isEnd;
  final int pageableCount;
  final int totalCount;

  Meta({
    required this.isEnd,
    required this.pageableCount,
    required this.totalCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      isEnd: json['is_end'] ?? false,
      pageableCount: json['pageable_count'] ?? 0,
      totalCount: json['total_count'] ?? 0,
    );
  }
}
