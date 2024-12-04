import 'dart:math';

import 'package:aoc2024/util.dart';

import 'advent_day.dart';

main() => Day3().solve();

class Day3 extends AdventDay {
  Day3() : super(3);

  final mulRegExp = RegExp(r"mul\(\d{1,3},\d{1,3}\)");
  final doRegExp = RegExp(r"do\(\)");
  final dontRegExp = RegExp(r"don't\(\)");

  @override
  part1(String input) {
    final mulMatches = mulRegExp.allMatches(input);
    final products = mulMatches.map((e) {
      final parameters = e
          .group(0)!
          .replaceAll('mul(', '')
          .replaceAll(")", "")
          .split(',')
          .map((e) => int.parse(e))
          .toList();
      return parameters[0] * parameters[1];
    });
    final sum = products.reduce((value, element) => value + element);
    return sum;
  }

  @override
  part2(String input) {
    final mulMatches = mulRegExp.allMatches(input);
    final doMatches = doRegExp.allMatches(input);
    final dontMatches = dontRegExp.allMatches(input);
    final doIndexes = doMatches.map((e) => e.start).toList()..add(0);
    final dontIndexes = dontMatches.map((e) => e.start).toList()..add(0);

    final products = mulMatches.map((e) {
      final doIndex = doIndexes.where((index) => index < e.start).reduce(max);
      final dontIndex =
          dontIndexes.where((index) => index < e.start).reduce(max);
      if (dontIndex > doIndex) {
        return 0;
      }

      final parameters = e
          .group(0)!
          .replaceAll('mul(', '')
          .replaceAll(")", "")
          .split(',')
          .map((e) => int.parse(e))
          .toList();
      return parameters[0] * parameters[1];
    });
    final sum = products.reduce((value, element) => value + element);
    return sum;
  }
}
