import 'dart:io';

import 'package:aoc2023/day5.dart';
import 'package:test/test.dart';

main() {
  final input = File('input/day5_test.txt').readAsStringSync().trimRight();
  test('Day5 part1', () {
    expect(Day5().part1(input), 35);
  });

  test('Day5 part1', () {
    expect(Day5().part2(input), 46);
  });
}
