import 'dart:convert';
import 'package:test/test.dart';
import 'package:wikipedia/src/model/summary.dart';
import 'package:wikipedia/src/model/article.dart';
import 'package:wikipedia/src/model/search_results.dart';

void main() {
  group('Summary model', () {
    test('can be created from JSON', () {
      final json = {
        'titles': {
          'canonical': 'Dart_(programming_language)',
          'normalized': 'Dart (programming language)',
          'display': 'Dart (programming language)'
        },
        'pageid': 12345,
        'extract': 'Dart is a programming language',
        'extract_html': '<p>Dart is a programming language</p>',
        'lang': 'en',
        'dir': 'ltr'
      };
      final summary = Summary.fromJson(json);
      expect(summary.titles.canonical, 'Dart_(programming_language)');
    });
  });

  group('Article model', () {
    test('listFromJson returns list of articles', () {
      final json = {
        'query': {
          'pages': {
            '123': {'title': 'Cat', 'extract': 'Cat is a pet'},
            '456': {'title': 'Dog', 'extract': 'Dog is a pet'}
          }
        }
      };
      final articles = Article.listFromJson(json);
      expect(articles.length, 2);
      expect(articles.first.title, 'Cat');
    });
  });

  group('SearchResults model', () {
    test('fromJson parses opensearch response', () {
      final json = [
        'dart',
        ['Dart', 'Dartmouth'],
        ['', ''],
        ['https://en.wikipedia.org/Dart', 'https://en.wikipedia.org/Dartmouth']
      ];
      final results = SearchResults.fromJson(json);
      expect(results.results.length, 2);
      expect(results.results.first.title, 'Dart');
    });
  });
}
