import 'dart:io';

import 'package:aoc2023/day7.dart';
import 'package:test/test.dart';

main() {
  final input = File('input/day7_test.txt').readAsStringSync().trimRight();
  test('Day7 part1', () {
    expect(Day7().part1(input), 6440);
  });

  test('Day7 part2', () {
    expect(Day7().part2(input), 46);
  });
}
