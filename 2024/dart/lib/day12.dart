import 'dart:math';

import 'package:aoc2024/util.dart';

import 'advent_day.dart';

final testData = """
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE""";

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(12);

  Set<Point<int>> tempGroup = {};

  @override
  part1(String input) {
    final matrix = input.matrix();
    final allFound = <Point<int>>{};
    final groups = <Set<Point<int>>>{};
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        final currentPoint = Point(j, i);
        if (allFound.contains(currentPoint)) {
          continue;
        }
        final newGroup = findGroup(matrix, currentPoint);
        groups.add(newGroup);
        allFound.addAll(newGroup);
      }
    }
    return groups.map((group) {
      final fences =
          group.map((s) => numberOfFences(matrix, s)).reduce((a, b) => a + b);
      return fences * group.length;
    }).reduce((a, b) => a + b);
  }

  int numberOfFences(List<List<String>> matrix, Point<int> point) {
    final crop = matrix.content(point);
    final up = matrix.safeContent(point.up());
    final right = matrix.safeContent(point.right());
    final down = matrix.safeContent(point.down());
    final left = matrix.safeContent(point.left());
    var fences = 0;
    if (crop != up) {
      fences++;
    }
    if (crop != right) {
      fences++;
    }
    if (crop != down) {
      fences++;
    }
    if (crop != left) {
      fences++;
    }
    return fences;
  }

  Set<Point<int>> findGroup(List<List<String>> matrix, Point<int> point) {
    tempGroup = {};
    final crop = matrix[point.y][point.x];
    findRec(matrix, point, crop);
    return tempGroup;
  }

  void findRec(List<List<String>> matrix, Point<int> current, String crop) {
    final neighbours = {
      current.up(),
      current.right(),
      current.down(),
      current.left()
    };

    final validNeighbours = neighbours.where((n) {
      if (n.inMatrix(matrix) &&
          matrix[n.y][n.x] == crop &&
          !tempGroup.contains(n)) {
        return true;
      }
      return false;
    }).toList();
    tempGroup.add(current);

    for (var n in validNeighbours) {
      findRec(matrix, n, crop);
    }
  }

  @override
  part2(String input) {
    final matrix = input.matrix();
    final allFound = <Point<int>>{};
    final groups = <Set<Point<int>>>{};
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        final currentPoint = Point(j, i);
        if (allFound.contains(currentPoint)) {
          continue;
        }
        final newGroup = findGroup(matrix, currentPoint);
        groups.add(newGroup);
        allFound.addAll(newGroup);
      }
    }
    return groups.map((group) {
      final fencesForGroup = calculateFencesForGroup(group);
      return fencesForGroup * group.length;
    }).reduce((a, b) => a + b);
  }

  int calculateFencesForGroup(Set<Point<int>> group) {
    var nFences = 0;
    Map<Point<int>, List<Dir>> fences = {};
    for (final point in group) {
      final up = point.up();
      if (!group.contains(up)) {
        // We need a fence
        final pointFences =
            fences.containsKey(point) ? fences[point]! : <Dir>[];
        if (!pointFences.contains(Dir.up)) {
          nFences++;
          fences[point] = [...pointFences, Dir.up];
          var toRight = point.right();
          while (true) {
            if (group.contains(toRight) && !group.contains(toRight.up())) {
              final rightFences =
                  fences.containsKey(toRight) ? fences[toRight]! : <Dir>[];
              fences[toRight] = [...rightFences, Dir.up];
            } else {
              break;
            }
            toRight = toRight.right();
          }
          var toLeft = point.left();
          while (true) {
            if (group.contains(toLeft) && !group.contains(toLeft.up())) {
              final leftFences =
                  fences.containsKey(toLeft) ? fences[toLeft]! : <Dir>[];
              fences[toLeft] = [...leftFences, Dir.up];
            } else {
              break;
            }
            toLeft = toLeft.left();
          }
        }
      }

      final right = point.right();
      if (!group.contains(right)) {
        // We need a fence
        final pointFences =
            fences.containsKey(point) ? fences[point]! : <Dir>[];
        final fenceDir = Dir.right;
        if (!pointFences.contains(fenceDir)) {
          nFences++;
          fences[point] = [...pointFences, fenceDir];
          var toUp = point.up();
          while (true) {
            if (group.contains(toUp) && !group.contains(toUp.right())) {
              final upFences =
                  fences.containsKey(toUp) ? fences[toUp]! : <Dir>[];
              fences[toUp] = [...upFences, fenceDir];
            } else {
              break;
            }
            toUp = toUp.up();
          }
          var toDown = point.down();
          while (true) {
            if (group.contains(toDown) && !group.contains(toDown.right())) {
              final downFences =
                  fences.containsKey(toDown) ? fences[toDown]! : <Dir>[];
              fences[toDown] = [...downFences, fenceDir];
            } else {
              break;
            }
            toDown = toDown.down();
          }
        }
      }

      final down = point.down();
      if (!group.contains(down)) {
        // We need a fence
        final pointFences =
            fences.containsKey(point) ? fences[point]! : <Dir>[];
        final fenceDir = Dir.down;
        if (!pointFences.contains(fenceDir)) {
          nFences++;
          fences[point] = [...pointFences, fenceDir];
          var toRight = point.right();
          while (true) {
            if (group.contains(toRight) && !group.contains(toRight.down())) {
              final rightFences =
                  fences.containsKey(toRight) ? fences[toRight]! : <Dir>[];
              fences[toRight] = [...rightFences, fenceDir];
            } else {
              break;
            }
            toRight = toRight.right();
          }
          var toLeft = point.left();
          while (true) {
            if (group.contains(toLeft) && !group.contains(toLeft.down())) {
              final leftFences =
                  fences.containsKey(toLeft) ? fences[toLeft]! : <Dir>[];
              fences[toLeft] = [...leftFences, fenceDir];
            } else {
              break;
            }
            toLeft = toLeft.left();
          }
        }
      }

      final left = point.left();
      if (!group.contains(left)) {
        // We need a fence
        final pointFences =
            fences.containsKey(point) ? fences[point]! : <Dir>[];
        final fenceDir = Dir.left;
        if (!pointFences.contains(fenceDir)) {
          nFences++;
          fences[point] = [...pointFences, fenceDir];
          var toUp = point.up();
          while (true) {
            if (group.contains(toUp) && !group.contains(toUp.left())) {
              final upFences =
                  fences.containsKey(toUp) ? fences[toUp]! : <Dir>[];
              fences[toUp] = [...upFences, fenceDir];
            } else {
              break;
            }
            toUp = toUp.up();
          }
          var toDown = point.down();
          while (true) {
            if (group.contains(toDown) && !group.contains(toDown.left())) {
              final downFences =
                  fences.containsKey(toDown) ? fences[toDown]! : <Dir>[];
              fences[toDown] = [...downFences, fenceDir];
            } else {
              break;
            }
            toDown = toDown.down();
          }
        }
      }
    }
    return nFences;
  }
}

enum Dir { up, right, down, left }
