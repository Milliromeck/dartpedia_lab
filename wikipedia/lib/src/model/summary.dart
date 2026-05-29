import 'title_set.dart';

class Summary {
  final TitlesSet titles;
  final int pageid;
  final String extract;
  final String extractHtml;
  final String? url;
  final String lang;
  final String dir;
  final String? description;

  Summary({
    required this.titles,
    required this.pageid,
    required this.extract,
    required this.extractHtml,
    this.url,
    required this.lang,
    required this.dir,
    this.description,
  });

  static Summary fromJson(Map<String, Object?> json) {
    return Summary(
      titles: TitlesSet.fromJson(json['titles'] as Map<String, Object?>),
      pageid: json['pageid'] as int,
      extract: json['extract'] as String,
      extractHtml: json['extract_html'] as String,
      url: (json['content_urls'] as Map<String, Object?>?)?['desktop']
          as String?,
      lang: json['lang'] as String,
      dir: json['dir'] as String,
      description: json['description'] as String?,
    );
  }
}
