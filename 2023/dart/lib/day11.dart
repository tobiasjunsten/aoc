import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(11);

  @override
  part1(String input) {
    final galaxy = input.rows().map((e) => e.split("")).toList();
    final emptyRows = findEmptyRows(galaxy);
    final emptyColumns = findEmptyColumns(galaxy);

    final planets = List<Planet>.empty(growable: true);
    for (int y = 0; y < galaxy.length; y++) {
      for (int x = 0; x < galaxy[y].length; x++) {
        if (galaxy[y][x] == "#") {
          planets.add(Planet(x: x, y: y));
        }
      }
    }

    final expandedPlanets = planets.map((p) {
      final emptyCols = emptyColumns.where((e) => e <= p.x).length;
      final emptyRs = emptyRows.where((e) => e <= p.y).length;
      final x = p.x + ((emptyCols) * 1000000) - emptyCols;
      final y = p.y + ((emptyRs) * 1000000) - emptyRs;
      return Planet(x: x, y: y);
    }).toList();

    var total = 0;
    for (int i = 0; i < expandedPlanets.length; i++) {
      for (int j = i; j < expandedPlanets.length; j++) {
        if (i != j) {
          total += (expandedPlanets[i].x - expandedPlanets[j].x).abs() +
              (expandedPlanets[i].y - expandedPlanets[j].y).abs();
        }
      }
    }

    print(total);

    print(planets);
    print(expandedPlanets.toList());

    return total;
  }

  List<int> findEmptyColumns(List<List<String>> galaxy) {
    final emptyColumns = List<int>.empty(growable: true);
    for (int i = 0; i < galaxy.length; i++) {
      var found = false;
      for (int j = 0; j < galaxy[i].length; j++) {
        if (galaxy[j][i] == "#") {
          found = true;
          break;
        }
      }
      if (!found) {
        emptyColumns.add(i);
      }
    }
    return emptyColumns;
  }

  List<int> findEmptyRows(List<List<String>> galaxy) {
    final emptyRows = List<int>.empty(growable: true);
    for (int i = 0; i < galaxy.length; i++) {
      if (!galaxy[i].contains("#")) {
        emptyRows.add(i);
      }
    }
    return emptyRows;
  }

  @override
  part2(String input) {
    return '';
  }
}

class Planet {
  final int x;
  final int y;

  Planet({required this.x, required this.y});

  @override
  String toString() {
    return "Planet: x: $x, y: $y";
  }
}
