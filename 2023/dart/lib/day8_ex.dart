import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';

main() => Day8().solve();

class Day8 extends AdventDay {
  Day8() : super(8);

  @override
  part1(String input) {
    final p = input.split("\n\n");
    final instructions = p[0].split("");
    final map = p[1].rows();

    final rows = Map<String, Lookup>();

    for (final instruction in map) {
      final parts = instruction.split(" = ");
      final key = parts[0];
      final look = parts[1].replaceAll("(", "").replaceAll(")", "").split(", ");
      rows.putIfAbsent(key, () => Lookup(left: look[0], right: look[1]));
    }

    int iterations = 0;
    bool found = false;
    String currentKey = rows.keys.first;

    while (!found) {
      final lookup = rows[currentKey]!;
      final instruction = instructions[iterations % instructions.length];
      final next = instruction == "L" ? lookup.left : lookup.right;
      if (next == "ZZZ") {
        found = true;
      }
      currentKey = next;
      iterations++;
    }

    return iterations;
  }

  @override
  part2(String input) {
    return '';
  }
}

class Lookup {
  final String left;
  final String right;

  Lookup({required this.left, required this.right});
}
