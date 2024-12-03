import 'package:aoc2024/util.dart';

import 'advent_day.dart';

main() => Day2().solve();

class Day2 extends AdventDay {
  Day2() : super(2);

  @override
  part1(String input) {
    final reports = input.rows();
    final safeReports = reports.where((report) => isSafe(report));
    return safeReports.length;
  }

  bool isSafe(String report) {
    final parts = report.split(" ").map((e) => int.parse(e)).toList();
    return safe(parts);
  }

  bool safe(List<int> parts) {
    List<int> result = [];
    for (int i = 0; i < parts.length - 1; i++) {
      result.add(parts[i + 1] - parts[i]);
    }
    final bigStep = result.where((e) => e.abs() > 3).isNotEmpty;
    final hasPositive = result.where((e) => e > 0).isNotEmpty;
    final hasNegative = result.where((e) => e < 0).isNotEmpty;
    final hasZero = result.where((e) => e == 0).isNotEmpty;
    return !bigStep && !hasZero && !(hasPositive && hasNegative);
  }

  @override
  part2(String input) {
    final reports = input.rows();
    final safeReports = reports.where((report) => isSafeWithDamper(report));
    return safeReports.length;
  }

  bool isSafeWithDamper(String report) {
    final parts = report.split(" ").map((e) => int.parse(e)).toList();
    if (safe(parts)) {
      return true;
    }
    for (int i = 0; i < parts.length; i++) {
      final dampedParts = [...parts]..removeAt(i);
      if (safe(dampedParts)) {
        return true;
      }
    }
    return false;
  }
}
