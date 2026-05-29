import 'dart:async';
import 'package:command_runner/command_runner.dart';
import 'package:wikipedia/wikipedia.dart';

class SearchCommand extends Command {
  SearchCommand() {
    addFlag('im-feeling-lucky', abbr: 'l', help: 'Show first result summary');
  }

  @override
  String get name => 'search';
  @override
  String get description => 'Search Wikipedia articles';
  @override
  bool get requiresArgument => true;
  @override
  String get valueHelp => 'QUERY';

  @override
  FutureOr<String> run(ArgResults args) async {
    final query = args.commandArg;
    if (query == null || query.isEmpty) {
      return 'Error: Please provide a search query';
    }

    final results = await search(query);
    if (results.results.isEmpty) {
      return 'No results found for "$query"';
    }

    final buffer = StringBuffer();
    
    if (args.flag('im-feeling-lucky')) {
      final first = results.results.first;
      final summary = await getArticleSummaryByTitle(first.title);
      buffer.writeln('=== ${summary.titles.normalized} ===');
      if (summary.description != null) buffer.writeln(summary.description);
      buffer.writeln(summary.extract);
      buffer.writeln('\n--- Other results ---');
    }

    for (var r in results.results) {
      buffer.writeln('• ${r.title}');
    }
    return buffer.toString();
  }
}
