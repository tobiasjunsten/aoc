import 'package:aoc2023/day3.dart';
import 'package:test/test.dart';

main() {
  test('examples', () {
    final t = '''
467..114..
...*......
..35..633.
....#.#...
617.......
.....+.58.
..592.....
......755.
...\$.*....
.664.598..
''';

    expect(Day3().part1(t), 3744);
  });
}
