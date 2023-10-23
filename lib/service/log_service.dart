import 'dart:developer' as dev;

class LogService {
  LogService._();

  static const bool _logActive = true;

  static void logLn(String str, {Object? error, ConsoleColor color = ConsoleColor.yellow}) {
    final leading = '\x1B[${color.foreground}${color.background}m';
    const trailing = '\x1B[0m';
    if (_logActive) {
      dev.log('$leading$str$trailing', error: error);
    }
  }
}

/// Konsol logları için renklendirme
enum ConsoleColor {
  white(foreground: '37', background: ''),
  purple(foreground: '35', background: ''),
  yellow(foreground: '33', background: ''),
  red(foreground: '31', background: ''),
  black(foreground: '30', background: ''),
  blackWhite(foreground: '30', background: ';47'),
  whiteRed(foreground: '37', background: ';41'),
  whitePurple(foreground: '37', background: ';45'),
  yellowRed(foreground: '33', background: ';41');

  const ConsoleColor({required this.foreground, this.background});

  final String foreground;
  final String? background;
}
