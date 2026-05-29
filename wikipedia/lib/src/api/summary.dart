import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/summary.dart';

Future<Summary> getArticleSummaryByTitle(String title) async {
  final url = Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/$title');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as Map<String, Object?>;
    return Summary.fromJson(json);
  }
  throw Exception('Failed to load article: $title');
}
