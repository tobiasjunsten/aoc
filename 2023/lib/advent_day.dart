import 'dart:io';

abstract class AdventDay {
  final int day;
  AdventDay(this.day);
  String part1(String input);
  String part2(String input);
  void solve() {
    final i = input();
    print('Part 1: ${part1(i)}');
    print('Part 2: ${part2(i)}');
  }

  String input() => File(_inputFileName).readAsStringSync();
  String get _inputFileName => '$inputFolder/day${day.toString()}.txt';
  static final inputFolder =
      String.fromEnvironment('AOC_INPUT_FOLDER', defaultValue: 'input');
}
