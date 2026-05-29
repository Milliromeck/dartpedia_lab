import 'package:command_runner/command_runner.dart';
import 'package:cli/src/commands/search_command.dart';
import 'package:cli/src/commands/article_command.dart';
import 'package:cli/src/logger.dart';

void main(List<String> arguments) {
  final errorLogger = initFileLogger('errors');
  
  final runner = CommandRunner(
    onError: (Object error) async {
      if (error is Exception) {
        errorLogger.severe(error.toString());
        await write('\n${error.toString().errorText}');
      } else if (error is Error) {
        errorLogger.severe('${error.toString()}\n${error.stackTrace}');
        await write('\n${error.toString().errorText}');
      }
    },
  )
    ..addCommand(HelpCommand())
    ..addCommand(SearchCommand())
    ..addCommand(ArticleCommand());
  
  runner.run(arguments);
}
