class Article {
  final String title;
  final String extract;

  Article({required this.title, required this.extract});

  static List<Article> listFromJson(Map<String, Object?> json) {
    final List<Article> articles = [];
    final pages = json['query']?['pages'] as Map<String, Object?>?;
    if (pages != null) {
      for (final page in pages.values) {
        final pageMap = page as Map<String, Object?>;
        articles.add(Article(
          title: pageMap['title'] as String,
          extract: pageMap['extract'] as String,
        ));
      }
    }
    return articles;
  }
}
