import 'dart:math';

import 'package:aoc2024/util.dart';

import 'advent_day.dart';

main() => Day6().solve();

String testData = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...""";

class Day6 extends AdventDay {
  Day6() : super(6, testData: testData);

  @override
  part1(String input) {
    final matrix = input.matrix();
    var position = getStart(matrix, "^");
    var direction = Point(0, -1);
    Set<Point> visitSet = {position};
    Set<Step> steps = {};

    while (true) {
      final nextPosition = position + direction;
      if (nextPosition.x < 0 ||
          nextPosition.x >= matrix[0].length ||
          nextPosition.y < 0 ||
          nextPosition.y >= matrix.length) {
        break;
      }
      if (matrix[nextPosition.y.toInt()][nextPosition.x.toInt()] == "#") {
        direction = direction.turnRight();
      } else {
        steps.add(Step(position, nextPosition));
        position = nextPosition;
        visitSet.add(position);
      }
    }

    return visitSet.length;
  }

  Point getStart(List<List<String>> matrix, String startString) {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == startString) {
          return Point(j, i);
        }
      }
    }
    return Point(-1, -1);
  }

  @override
  part2(String input) {
    final matrix = input.matrix();
    var position = getStart(matrix, "^");
    var direction = Point(0, -1);
    var count = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == "#" || matrix[i][j] == "^") {
          continue;
        }
        matrix[i][j] = "#";
        if (hasLoop(matrix, position, direction)) {
          print("***** Loop at $j, $i");
          count++;
        } else {
          print("No loop at $j, $i");
        }
        matrix[i][j] = ".";
      }
    }
    return count;
  }

  bool hasLoop(List<List<String>> matrix, Point position, Point direction) {
    Set<Point> visits = {position};
    Set<Step> steps = {};
    while (true) {
      final nextPosition = position + direction;
      if (nextPosition.x < 0 ||
          nextPosition.x >= matrix[0].length ||
          nextPosition.y < 0 ||
          nextPosition.y >= matrix.length) {
        return false;
      }
      if (matrix[nextPosition.y.toInt()][nextPosition.x.toInt()] == "#") {
        direction = direction.turnRight();
      } else {
        if (visits.contains(nextPosition)) {
          if (steps.any(
              (step) => step.from == position && step.to == nextPosition)) {
            return true;
          }
        }
        steps.add(Step(position, nextPosition));
        position = nextPosition;
        visits.add(position);
      }
    }
  }
}

class Step {
  final Point from;
  final Point to;

  const Step(this.from, this.to);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Step && other.from == from && other.to == to;
  }
}

extension Rotate on Point {
  Point<int> turnRight() {
    if (this == Point(0, -1)) {
      return Point(1, 0);
    } else if (this == Point(1, 0)) {
      return Point(0, 1);
    } else if (this == Point(0, 1)) {
      return Point(-1, 0);
    } else {
      return Point(0, -1);
    }
  }
}
