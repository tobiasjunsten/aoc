import 'package:aoc2024/util.dart';

import 'advent_day.dart';

main() => Day4().solve();

class Day4 extends AdventDay {
  Day4() : super(4);

  @override
  part1(String input) {
    final rows = input.rows();
    final matrix = rows.map((e) => e.split("")).toList();
    var sum = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == 'X') {
          sum += findXmasNumberOfXmases(matrix, i, j);
        }
      }
    }
    return sum;
  }

  int findXmasNumberOfXmases(List<List<String>> matrix, int i, int j) {
    var count = 0;

    // East
    if (findXmas(matrix, i, j, 0, 1)) {
      count++;
    }

    // South
    if (findXmas(matrix, i, j, 1, 0)) {
      count++;
    }

    // South-East
    if (findXmas(matrix, i, j, 1, 1)) {
      count++;
    }

    // South-West
    if (findXmas(matrix, i, j, 1, -1)) {
      count++;
    }

    // West
    if (findXmas(matrix, i, j, 0, -1)) {
      count++;
    }

    // North-West
    if (findXmas(matrix, i, j, -1, -1)) {
      count++;
    }

    // North
    if (findXmas(matrix, i, j, -1, 0)) {
      count++;
    }

    // North-East
    if (findXmas(matrix, i, j, -1, 1)) {
      count++;
    }

    return count;
  }

  bool findXmas(List<List<String>> matrix, int y, int x, int yDir, int xDir) {
    try {
      return matrix[y][x] == 'X' &&
          matrix[y + yDir][x + xDir] == 'M' &&
          matrix[y + yDir * 2][x + xDir * 2] == 'A' &&
          matrix[y + yDir * 3][x + xDir * 3] == 'S';
    } catch (e) {
      return false;
    }
  }

  @override
  part2(String input) {
    final rows = input.rows();
    final matrix = rows.map((e) => e.split("")).toList();
    var sum = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == 'A') {
          sum += findCrosses(matrix, i, j);
        }
      }
    }
    return sum;
  }

  int findCrosses(List<List<String>> matrix, int i, int j) {
    int count = 0;
    try {
      if (matrix[i - 1][j - 1] == 'M' && // top left
              matrix[i - 1][j + 1] == 'M' && // top right
              matrix[i + 1][j - 1] == 'S' && // bottom left
              matrix[i + 1][j + 1] == 'S' // bottom right
          ) {
        count++;
      }
    } catch (e) {
      // do nothing
    }

    try {
      if (matrix[i - 1][j - 1] == 'S' && // top left
              matrix[i - 1][j + 1] == 'S' && // top right
              matrix[i + 1][j - 1] == 'M' && // bottom left
              matrix[i + 1][j + 1] == 'M' // bottom right
          ) {
        count++;
      }
    } catch (e) {
      // do nothing
    }

    try {
      if (matrix[i - 1][j - 1] == 'M' && // top left
              matrix[i - 1][j + 1] == 'S' && // top right
              matrix[i + 1][j - 1] == 'M' && // bottom left
              matrix[i + 1][j + 1] == 'S' // bottom right
          ) {
        count++;
      }
    } catch (e) {
      // do nothing
    }

    try {
      if (matrix[i - 1][j - 1] == 'S' && // top left
              matrix[i - 1][j + 1] == 'M' && // top right
              matrix[i + 1][j - 1] == 'S' && // bottom left
              matrix[i + 1][j + 1] == 'M' // bottom right
          ) {
        count++;
      }
    } catch (e) {
      // do nothing
    }

    return count;
  }
}
