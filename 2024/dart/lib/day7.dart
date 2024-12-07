import 'package:aoc2024/util.dart';

import 'advent_day.dart';

main() => Day7().solve();

final testData = """
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20""";

class Day7 extends AdventDay {
  Day7() : super(7, testData: testData);

  @override
  part1(String input) {
    final equations = input.rows();
    return equations
        .map((e) {
          final parts = e.split(": ");
          final result = int.parse(parts[0]);
          final numbers = parts[1].split(" ").map((e) => int.parse(e)).toList();
          return hasOperatorMatch(result, numbers) ? result : 0;
        })
        .toList()
        .reduce((a, b) => a + b);
  }

  @override
  part2(String input) {
    final equations = input.rows();
    return equations
        .map((e) {
          final parts = e.split(": ");
          final result = int.parse(parts[0]);
          final numbers = parts[1].split(" ").map((e) => int.parse(e)).toList();
          return hasOperatorMatch(result, numbers) ? result : 0;
        })
        .toList()
        .reduce((a, b) => a + b);
  }

  hasOperatorMatch(int result, List<int> numbers) {
    return opRec(result, numbers.first, numbers.sublist(1));
  }

  bool opRec(int target, int current, List<int> numbers) {
    if (numbers.isEmpty) {
      return current == target;
    }
    if (current > target) {
      return false;
    }

    final nextNumber = numbers.first;
    final remainingNumbers = numbers.sublist(1);

    return opRec(target, current + nextNumber, remainingNumbers) ||
        opRec(target, current * nextNumber, remainingNumbers) ||
        opRec(
            target,
            int.parse("${current.toString()}${nextNumber.toString()}"),
            remainingNumbers);
  }
}
