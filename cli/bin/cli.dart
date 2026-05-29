import 'package:command_runner/command_runner.dart';
import 'package:cli/src/commands/search_command.dart';
import 'package:cli/src/commands/article_command.dart';

void main(List<String> arguments) {
  final runner = CommandRunner()
    ..addCommand(HelpCommand())
    ..addCommand(SearchCommand())
    ..addCommand(ArticleCommand());
  
  runner.run(arguments);
}
