import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';
import 'package:collection/collection.dart';

main() => Day2().solve();

class Day2 extends AdventDay {
  Day2() : super(2);

  @override
  dynamic part1(String input) {
    final games = input.rows().map(parseGames);
    final valid = games.where((g) => !g.cubeColors.any((cc) =>
        (cc.color == "red" && cc.number > 12) ||
        (cc.color == "green" && cc.number > 13) ||
        (cc.color == "blue" && cc.number > 14)));
    return valid.map((e) => e.gameNumber).sum;
  }

  @override
  dynamic part2(String input) {
    final games = input.rows().map(parseGames);
    final gameScores = games.map((g) {
      final redMin = g.cubeColors
          .where((cc) => cc.color == "red")
          .map((e) => e.number)
          .max;
      final greenMin = g.cubeColors
          .where((cc) => cc.color == "green")
          .map((e) => e.number)
          .max;
      final blueMin = g.cubeColors
          .where((cc) => cc.color == "blue")
          .map((e) => e.number)
          .max;
      return redMin * greenMin * blueMin;
    });
    return gameScores.sum;
  }

  Game parseGames(String gameString) {
    final rounds = gameString.split(":")[1];
    final colors = rounds.split(RegExp('[,;]'));
    final cubeColors = colors.map((e) {
      final s = e.trim().split(" ");
      return CubeColor(color: s[1], number: int.parse(s[0]));
    }).toList();
    final gameNumber = int.parse(gameString.split(":")[0].split(" ")[1]);
    return Game(cubeColors: cubeColors, gameNumber: gameNumber);
  }
}

class Game {
  final int gameNumber;
  final List<CubeColor> cubeColors;

  Game({required this.gameNumber, required this.cubeColors});
}

class CubeColor {
  final String color;
  final int number;

  CubeColor({required this.color, required this.number});
}
