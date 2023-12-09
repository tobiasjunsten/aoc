import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';
import 'package:collection/collection.dart';

main() => Day9().solve();

class Day9 extends AdventDay {
  Day9() : super(9);

  @override
  part1(String input) {
    final parts = input.rows();
    final predictions =
        parts.map((i) => i.split(" ").map(int.parse).toList()).map(recPred);
    return predictions.sum;
  }

  @override
  part2(String input) {
    final parts = input.rows();
    final predictions = parts
        .map((i) => i.split(" ").map(int.parse).toList().reversed.toList())
        .map(recPred);
    return predictions.sum;
  }

  int recPred(List<int> incoming) {
    final next = List<int>.empty(growable: true);
    for (int i = 0; i < incoming.length - 1; i++) {
      next.add(incoming[i + 1] - incoming[i]);
    }
    if (next.where((e) => e != 0).isEmpty) {
      return incoming.last;
    } else {
      return incoming.last + recPred(next);
    }
  }
}
