import 'package:aoc2024/util.dart';

import 'advent_day.dart';

main() => Day1().solve();

class Day1 extends AdventDay {
  Day1() : super(1);

  @override
  part1(String input) {
    final rows = input.rows();
    final left = rows.map((e) => e.split("   ")[0]).toList()..sort();
    final right = rows.map((e) => e.split("   ")[1]).toList()..sort();
    var sum = 0;
    for (int i = 0; i < left.length; i++) {
      sum += (int.parse(left[i]) - int.parse(right[i])).abs();
    }
    return sum;
  }

  @override
  part2(String input) {
    final rows = input.rows();
    final left = rows.map((e) => e.split("   ")[0]).toList();
    final right = rows.map((e) => e.split("   ")[1]).toList();
    var sum = 0;
    for (int i = 0; i < left.length; i++) {
      final number = left[i];
      final count = right.where((e) => e == number).length;
      if (count > 0) {
        sum += int.parse(number) * count;
      }
    }
    return sum;
  }
}
