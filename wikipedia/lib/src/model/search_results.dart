class SearchResult {
  final String title;
  final String url;
  SearchResult({required this.title, required this.url});
}

class SearchResults {
  final List<SearchResult> results;
  final String? searchTerm;

  SearchResults(this.results, {this.searchTerm});

  static SearchResults fromJson(List<Object?> json) {
    final results = <SearchResult>[];
    if (json.length >= 4) {
      final titles = json[1] as List<Object?>;
      final urls = json[3] as List<Object?>;
      for (int i = 0; i < titles.length; i++) {
        results.add(SearchResult(
          title: titles[i] as String,
          url: urls[i] as String,
        ));
      }
    }
    return SearchResults(results);
  }
}
