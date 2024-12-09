import 'dart:math';

import 'package:aoc2024/util.dart';

import 'advent_day.dart';

final testData = """
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............""";

main() => Day8().solve();

class Day8 extends AdventDay {
  Day8() : super(8, testData: testData);

  @override
  part1(String input) {
    final matrix = input.matrix();
    final antennaLocations = getAntennaLocations(matrix);
    final antiNodes = antennaLocations.values
        .expand((antennas) => calculateAntiNodes(antennas))
        .where((point) => isInsideMatrix(point, matrix))
        .toList();
    return {...antiNodes}.length;
  }

  bool isInsideMatrix(Point point, List<List<String>> matrix) {
    return point.x >= 0 &&
        point.x < matrix[0].length &&
        point.y >= 0 &&
        point.y < matrix.length;
  }

  List<Point> calculateAntiNodes(List<Point> antennas) {
    final pairs = getPairs(antennas);
    return pairs.expand((pair) {
      final dx = (pair.first.x - pair.second.x).abs();
      final dy = (pair.first.y - pair.second.y).abs();
      final firstX =
          pair.first.x > pair.second.x ? pair.first.x + dx : pair.first.x - dx;
      final firstY =
          pair.first.y > pair.second.y ? pair.first.y + dy : pair.first.y - dy;
      final secondX = pair.second.x > pair.first.x
          ? pair.second.x + dx
          : pair.second.x - dx;
      final secondY = pair.second.y > pair.first.y
          ? pair.second.y + dy
          : pair.second.y - dy;

      return [Point(firstX, firstY), Point(secondX, secondY)];
    }).toList();
  }

  List<Pair> getPairs(List<Point> points) {
    List<Pair> pairs = [];
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        pairs.add(Pair(points[i], points[j]));
      }
    }
    return pairs;
  }

  Map<String, List<Point>> getAntennaLocations(List<List<String>> matrix) {
    Map<String, List<Point>> antennaLocations = {};
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        final char = matrix[i][j];
        if (char != ".") {
          if (antennaLocations.containsKey(char)) {
            antennaLocations[char]!.add(Point(j, i));
          } else {
            antennaLocations[char] = [Point(j, i)];
          }
        }
      }
    }
    return antennaLocations;
  }

  @override
  part2(String input) {
    final matrix = input.matrix();
    final antennaLocations = getAntennaLocations(matrix);
    final antiNodes = antennaLocations.values
        .expand((antennas) => calculateExtendedAntiNodes(antennas, matrix));
    return {...antiNodes}.length;
  }

  List<Point> calculateExtendedAntiNodes(
      List<Point> antennas, List<List<String>> matrix) {
    final pairs = getPairs(antennas);
    return pairs.expand((pair) {
      final dx = (pair.first.x - pair.second.x).abs();
      final dy = (pair.first.y - pair.second.y).abs();
      final firstDx = pair.first.x > pair.second.x ? dx : -dx;
      final firstDy = pair.first.y > pair.second.y ? dy : -dy;
      final secondDx = pair.second.x > pair.first.x ? dx : -dx;
      final secondDy = pair.second.y > pair.first.y ? dy : -dy;

      var fromFirst = <Point>[];
      var nextX = pair.first.x;
      var nextY = pair.first.y;
      while (true) {
        nextX += firstDx;
        nextY += firstDy;
        final nextPoint = Point(nextX, nextY);
        if (!isInsideMatrix(nextPoint, matrix)) {
          break;
        }
        fromFirst.add(Point(nextX, nextY));
      }

      var fromSecond = <Point>[];
      nextX = pair.second.x;
      nextY = pair.second.y;
      while (true) {
        nextX += secondDx;
        nextY += secondDy;
        final nextPoint = Point(nextX, nextY);
        if (!isInsideMatrix(nextPoint, matrix)) {
          break;
        }
        fromSecond.add(Point(nextX, nextY));
      }

      return [...fromFirst, ...fromSecond, pair.first, pair.second];
    }).toList();
  }
}

class Pair {
  final Point first;
  final Point second;

  Pair(this.first, this.second);
}
