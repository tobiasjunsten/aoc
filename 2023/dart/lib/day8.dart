import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';

main() => Day8().solve();

class Day8 extends AdventDay {
  Day8() : super(8);

  @override
  part1(String input) {
    final (instructions, nodes) = parseInput(input);

    var currentNode = "AAA";
    var iterations = 0;
    while (currentNode != "ZZZ") {
      final position = iterations % instructions.length;
      final lookup = nodes[currentNode];
      final instruction = instructions[position];
      currentNode = instruction == "L" ? lookup!.$1 : lookup!.$2;
      iterations++;
    }

    return iterations;
  }

  @override
  part2(String input) {
    final (instructions, nodes) = parseInput(input);

    var currentNodes = nodes.keys.where((key) => key.endsWith("A")).toList();
    var iterations = 0;
    var found = false;
    var r = List<int>.empty(growable: true);
    while (!found) {
      final position = iterations % instructions.length;
      iterations++;
      currentNodes = currentNodes
          .map((e) => nextNode(e, nodes, instructions[position]))
          .toList();
      final notEndingWithZ =
          currentNodes.where((e) => !e.endsWith("Z")).toList();
      if (notEndingWithZ.length != currentNodes.length) {
        r.add(iterations);
        currentNodes = notEndingWithZ;
      }
      if (notEndingWithZ.isEmpty) {
        found = true;
      }
    }

    return leastCommon(r);
  }

  leastCommon(List<int> numbers) {
    final start = numbers[0];
    final lcm = numbers.sublist(1).fold(start, (previousValue, element) {
      final z = gcd(previousValue, element);
      return (previousValue * element) ~/ z;
    });
    return lcm;
  }

  int gcd(int a, int b) {
    if (b == 0)
      return a;
    else
      return gcd(b, a % b);
  }

  getLeastCommon(n1, n2) {
    int max = n1 > n2 ? n1 : n2;
    while (true) {
      if (max % n1 == 0 && max % n2 == 0) {
        return max;
      }
      max++;
    }
  }

  String nextNode(String currentNode, Map<String, (String, String)> nodeMap,
      String instruction) {
    final lookup = nodeMap[currentNode];
    return instruction == "L" ? lookup!.$1 : lookup!.$2;
  }

  (String, Map<String, (String, String)>) parseInput(String input) {
    final parts = input.split("\n\n");
    final instructions = parts[0];
    final network = parts[1].rows();
    var nodes = Map<String, (String, String)>.fromIterable(network,
        key: (v) => v.split(" = ")[0],
        value: (v) {
          final lookups = v
              .split(" = ")[1]
              .replaceAll("(", "")
              .replaceAll(")", "")
              .split(", ");
          return (lookups[0], lookups[1]);
        });
    return (instructions, nodes);
  }
}
