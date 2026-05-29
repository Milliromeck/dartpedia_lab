class TitlesSet {
  final String canonical;
  final String normalized;
  final String display;

  TitlesSet({
    required this.canonical,
    required this.normalized,
    required this.display,
  });

  static TitlesSet fromJson(Map<String, Object?> json) {
    return TitlesSet(
      canonical: json['canonical'] as String,
      normalized: json['normalized'] as String,
      display: json['display'] as String,
    );
  }
}
