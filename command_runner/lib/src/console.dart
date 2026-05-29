import 'dart:io';

const String ansiEscapeLiteral = '\x1B';

Future<void> write(String text, {int duration = 50}) async {
  final List<String> lines = text.split('\n');
  for (final String l in lines) {
    await Future<void>.delayed(
      Duration(milliseconds: duration),
      () => stdout.write('$l \n'),
    );
  }
}

enum ConsoleColor {
  lightBlue(184, 234, 254),
  red(242, 93, 80),
  yellow(249, 248, 196),
  grey(240, 240, 240),
  white(255, 255, 255);

  const ConsoleColor(this.r, this.g, this.b);
  final int r, g, b;

  String get enableForeground => '$ansiEscapeLiteral[38;2;$r;$g;${b}m';
  static String get reset => '$ansiEscapeLiteral[0m';

  String applyForeground(String text) =>
      '$ansiEscapeLiteral[38;2;$r;$g;${b}m$text$reset';
}

extension TextRenderUtils on String {
  String get errorText => ConsoleColor.red.applyForeground(this);
  String get instructionText => ConsoleColor.yellow.applyForeground(this);
  String get titleText => ConsoleColor.lightBlue.applyForeground(this);
}
