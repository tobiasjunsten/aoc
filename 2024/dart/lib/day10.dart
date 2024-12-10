import 'dart:math';

import 'package:aoc2024/util.dart';

import 'advent_day.dart';

final testData = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732""";

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(10);

  @override
  part1(String input) {
    final matrix = input.intMatrix();
    var sum = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == 0) {
          final endPoints = findHeads(matrix, Point(j, i), -1);
          final uniqueEndPoints = endPoints.toSet();
          sum += uniqueEndPoints.length;
        }
      }
    }
    return sum;
  }

  List<Point<int>> findHeads(
      List<List<int>> matrix, Point<int> currentPoint, int previousHeight) {
    if (!currentPoint.inMatrix(matrix)) {
      return [];
    }
    final currentHeight = matrix[currentPoint.y][currentPoint.x];
    if (currentHeight != previousHeight + 1) {
      return [];
    }
    if (currentHeight == 9) {
      return [currentPoint];
    }
    return [
      ...findHeads(matrix, currentPoint + Point(1, 0), currentHeight),
      ...findHeads(matrix, currentPoint + Point(-1, 0), currentHeight),
      ...findHeads(matrix, currentPoint + Point(0, 1), currentHeight),
      ...findHeads(matrix, currentPoint + Point(0, -1), currentHeight),
    ];
  }

  @override
  part2(String input) {
    final matrix = input.intMatrix();
    var sum = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == 0) {
          final endPoints = findHeads(matrix, Point(j, i), -1);
          sum += endPoints.length;
        }
      }
    }
    return sum;
  }
}
