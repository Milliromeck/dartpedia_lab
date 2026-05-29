import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'arguments.dart';
import 'exceptions.dart';

class CommandRunner {
  CommandRunner({this.onError});

  final Map<String, Command> _commands = <String, Command>{};
  FutureOr<void> Function(Object)? onError;

  UnmodifiableSetView<Command> get commands =>
      UnmodifiableSetView<Command>(<Command>{..._commands.values});

  Future<void> run(List<String> input) async {
    try {
      if (input.isEmpty) {
        print(usage);
        return;
      }
      
      final ArgResults results = parse(input);
      if (results.command != null) {
        Object? output = await results.command!.run(results);
        if (output != null) print(output);
      }
    } on Exception catch (e) {
      if (onError != null) {
        await onError!(e);
      } else {
        rethrow;
      }
    }
  }

  void addCommand(Command command) {
    _commands[command.name] = command;
    command.runner = this;
  }

  ArgResults parse(List<String> input) {
    ArgResults results = ArgResults();
    if (input.isEmpty) return results;

    if (!_commands.containsKey(input.first)) {
      throw ArgumentException(
        'Unknown command: ${input.first}',
        null,
        input.first,
      );
    }
    
    results.command = _commands[input.first];
    if (input.length > 1) {
      results.commandArg = input.sublist(1).join(' ');
    }
    
    return results;
  }

  String get usage {
    final exeFile = Platform.script.path.split('/').last;
    var output = 'Usage: dart bin/$exeFile <command> [args]\n';
    output += '\nAvailable commands:\n';
    for (var command in _commands.values) {
      output += '  ${command.name}: ${command.description}\n';
    }
    return output;
  }
}
