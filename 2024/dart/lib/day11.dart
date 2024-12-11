import 'advent_day.dart';

final testData = """
125 17""";

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(11, testData: testData);

  @override
  part1(String input) {
    var numbers = input.split(" ");
    for (int i = 0; i < 25; i++) {
      print("$i: ${numbers.length}");
      numbers = numbers.expand((e) => appyRules(e)).toList();
    }
    return numbers.length;
  }

  @override
  part2(String input) {
    var numbers = input.split(" ");
    Map<String, int> stones = {};
    for (final n in numbers) {
      if (stones.containsKey(n)) {
        stones[n] = stones[n]! + 1;
      } else {
        stones[n] = 1;
      }
    }
    for (int i = 0; i < 75; i++) {
      final newStones = <String, int>{};
      for (final stone in stones.keys) {
        final count = stones[stone]!;
        for (final newStone in appyRules(stone)) {
          if (newStones.containsKey(newStone)) {
            newStones[newStone] = newStones[newStone]! + count;
          } else {
            newStones[newStone] = count;
          }
        }
      }
      stones = newStones;
    }
    return stones.values.reduce((value, element) => value + element);
  }

  List<String> appyRules(String e) {
    final intValue = int.parse(e);
    final length = e.length;
    if (e == "0") {
      return ["1"];
    } else if (e == "1") {
      return ["2024"];
    } else if (length % 2 == 0) {
      return [
        int.parse(e.substring(0, length ~/ 2)).toString(),
        int.parse(e.substring(length ~/ 2)).toString()
      ];
    } else {
      return [(intValue * 2024).toString()];
    }
  }
}
