import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';

main() => Day8().solve();

class Day8 extends AdventDay {
  Day8() : super(8);

  @override
  part1(String input) {
    final parts = input.split("\n\n");
    final instructions = parts[0];
    final network = parts[1].rows();
    var nodes = Map.fromIterable(network,
        key: (v) => v.split(" = ")[0],
        value: (v) {
          final lookups = v
              .split(" = ")[1]
              .replaceAll("(", "")
              .replaceAll(")", "")
              .split(", ");
          return (lookups[0], lookups[1]);
        });

    var currentNode = "AAA";
    var iterations = 0;
    while (currentNode != "ZZZ") {
      final position = iterations % instructions.length;
      final lookup = nodes[currentNode];
      final instruction = instructions[position];
      currentNode = instruction == "L" ? lookup?.$1 : lookup?.$2;
      iterations++;
    }

    return iterations;
  }

  @override
  part2(String input) {
    return '';
  }
}
