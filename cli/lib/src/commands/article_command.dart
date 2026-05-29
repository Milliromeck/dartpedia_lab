import 'dart:async';
import 'package:command_runner/command_runner.dart';
import 'package:wikipedia/wikipedia.dart';

class ArticleCommand extends Command {
  @override
  String get name => 'article';
  @override
  String get description => 'Get Wikipedia article by title';
  @override
  bool get requiresArgument => true;
  @override
  String get valueHelp => 'TITLE';
  @override
  String get defaultValue => 'Flutter';

  @override
  FutureOr<String> run(ArgResults args) async {
    final title = args.commandArg ?? defaultValue;
    final summary = await getArticleSummaryByTitle(title);
    
    final buffer = StringBuffer();
    buffer.writeln('\n=== ${summary.titles.normalized} ===');
    if (summary.description != null) buffer.writeln(summary.description);
    buffer.writeln('\n${summary.extract}');
    return buffer.toString();
  }
}
