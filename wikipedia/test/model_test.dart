import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:wikipedia/wikipedia.dart';

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
      expect(summary.extract, 'Dart is a programming language');
    });
  });
}
