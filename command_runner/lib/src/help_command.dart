import 'dart:async';
import 'arguments.dart';
import 'console.dart';

class HelpCommand extends Command {
  HelpCommand() {
    addFlag('verbose', abbr: 'v', help: 'Show detailed command information');
  }

  @override
  String get name => 'help';
  @override
  String get description => 'Prints usage information';

  @override
  FutureOr<String> run(ArgResults args) async {
    final buffer = StringBuffer();
    buffer.writeln(runner.usage.titleText);

    if (args.flag('verbose')) {
      for (final cmd in runner.commands) {
        buffer.writeln('\n${cmd.usage.instructionText}');
        if (cmd.help != null) buffer.writeln('  ${cmd.help}');
        buffer.writeln('  Options:');
        for (final opt in cmd.options) {
          buffer.writeln('    ${opt.usage}');
        }
      }
    } else {
      for (final cmd in runner.commands) {
        buffer.writeln(cmd.usage);
      }
    }
    return buffer.toString();
  }
}
