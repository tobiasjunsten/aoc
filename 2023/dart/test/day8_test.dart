import 'dart:io';

import 'package:aoc2023/day8.dart';
import 'package:test/test.dart';

main() {
  final input = File('input/day8_test.txt').readAsStringSync().trimRight();
  test('Day8 part1', () {
    expect(Day8().part1(input), 6);
  });

  test('Day8 part2', () {
    expect(Day8().part2(input), 46);
  });
}
