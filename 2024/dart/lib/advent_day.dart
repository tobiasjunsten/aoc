import 'dart:io';

abstract class AdventDay {
  final int day;
  String? testData;
  AdventDay(this.day, {this.testData});
  dynamic part1(String input);
  dynamic part2(String input);
  void solve() {
    String i;
    if (testData != null) {
      i = testData!;
    } else {
      i = input();
    }
    print('Part 1: ${part1(i)}');
    print('Part 2: ${part2(i)}');
  }

  String input() => File(_inputFileName).readAsStringSync().trimRight();
  String get _inputFileName => '$inputFolder/day${day.toString()}.txt';
  static final inputFolder =
      String.fromEnvironment('AOC_INPUT_FOLDER', defaultValue: 'input');
}
