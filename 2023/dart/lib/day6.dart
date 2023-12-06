import 'package:aoc2023/advent_day.dart';

main() => Day6().solve();

class Day6 extends AdventDay {
  Day6() : super(6);

  @override
  part1(String input) {
    final a = numberOfWays(41, 244);
    final b = numberOfWays(66, 1047);
    final c = numberOfWays(72, 1228);
    final d = numberOfWays(66, 1040);
    final e = a * b * c * d;
    return e;
  }

  @override
  part2(String input) {
    return numberOfWays(41667266, 244104712281040);
  }

  int numberOfWays(int time, int record) {
    int records = 0;
    for (int i = 0; i <= time; i++) {
      final distance = (time - i) * i;
      if (distance > record) {
        records++;
      }
    }
    return records;
  }
}
