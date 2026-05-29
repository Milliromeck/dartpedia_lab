import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/search_results.dart';

Future<SearchResults> search(String query) async {
  final url = Uri.https('en.wikipedia.org', '/w/api.php', {
    'action': 'opensearch',
    'format': 'json',
    'search': query,
  });
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as List<Object?>;
    return SearchResults.fromJson(json);
  }
  throw Exception('Failed to search: $query');
}
