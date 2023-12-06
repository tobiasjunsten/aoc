import 'dart:io';

import 'package:aoc2023/day6.dart';
import 'package:test/test.dart';

main() {
  final input = File('input/day6_test.txt').readAsStringSync().trimRight();
  test('Day6 part1', () {
    expect(Day6().part1(input), 35);
  });

  test('Day6 part2', () {
    expect(Day6().part2(input), 46);
  });
}
