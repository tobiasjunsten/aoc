import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(10);

  final (int, int) RIGHT = (0, 1);
  final (int, int) DOWN = (1, 0);
  final (int, int) LEFT = (0, -1);
  final (int, int) UP = (-1, 0);

  @override
  part1(String input) {
    final grid = input.rows().map((e) => e.split("")).toList();
    final pipes = getPipes(grid);
    print("Pipes: ${pipes.length}");
    return pipes.length ~/ 2;
  }

  @override
  part2(String input) {
    final grid = input.rows().map((e) => e.split("")).toList();
    final pipes = getPipes(grid);
    print("Pipes: ${pipes.length}");
    var count = 0;
    for (int y = 0; y < grid.length; y++) {
      for (int x = 0; x < grid[y].length; x++) {
        if (pipes
                        .where((pipe) =>
                            "S|JL".contains(pipe.type) &&
                            pipe.x < x &&
                            pipe.y == y)
                        .length %
                    2 ==
                1 &&
            !pipes.any((pipe) => pipe.x == x && pipe.y == y)) {
          print("Found at: $y, $x");
          count++;
        }
      }
    }
    return count;
  }

  List<Pipe> getPipes(List<List<String>> grid) {
    final start = getStart(grid);
    print(grid);
    final startingDirection = findStartingDirection(grid, start);
    print(startingDirection);
    var currentPipe = "";
    var currentDirection = startingDirection;
    var nextDirection = currentDirection;
    var currentLocation = start;

    final pipes = List<Pipe>.empty(growable: true);
    while (currentPipe != "S") {
      final nextLocation = currentLocation.plus(currentDirection);
      final nextPipe = grid.get(nextLocation);
      if (currentDirection == RIGHT) {
        if (nextPipe == "-") {
          nextDirection = RIGHT;
        } else if (nextPipe == "J") {
          nextDirection = UP;
        } else if (nextPipe == "7") {
          nextDirection = DOWN;
        }
      } else if (currentDirection == DOWN) {
        if (nextPipe == "|") {
          nextDirection = DOWN;
        } else if (nextPipe == "L") {
          nextDirection = RIGHT;
        } else if (nextPipe == "J") {
          nextDirection = LEFT;
        }
      } else if (currentDirection == LEFT) {
        if (nextPipe == "-") {
          nextDirection = LEFT;
        } else if (nextPipe == "L") {
          nextDirection = UP;
        } else if (nextPipe == "F") {
          nextDirection = DOWN;
        }
      } else if (currentDirection == UP) {
        if (nextPipe == "|") {
          nextDirection = UP;
        } else if (nextPipe == "F") {
          nextDirection = RIGHT;
        } else if (nextPipe == "7") {
          nextDirection = LEFT;
        }
      }
      currentDirection = nextDirection;
      currentPipe = nextPipe;
      currentLocation = nextLocation;
      pipes.add(Pipe(
          type: currentPipe, x: currentLocation.$2, y: currentLocation.$1));
    }
    return pipes;
  }

  (int, int) findStartingDirection(
      List<List<String>> grid, (int, int) startPosition) {
    if (startPosition.$1 - 1 > 0 &&
        "7|F".contains(grid[startPosition.$1 - 1][startPosition.$2])) {
      return UP;
    } else if (startPosition.$2 + 1 < grid[0].length &&
        "7-J".contains(grid[startPosition.$1][startPosition.$2 + 1])) {
      return RIGHT;
    } else if (startPosition.$1 + 1 < grid.length &&
        "|JL".contains(grid[startPosition.$1 + 1][startPosition.$2])) {
      return DOWN;
    } else if (startPosition.$2 - 1 > 0 &&
        "-LF".contains(grid[startPosition.$1][startPosition.$2 - 1])) {
      return LEFT;
    }
    return (0, 0);
  }

  (int, int) getStart(List<List<String>> grid) {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == "S") {
          return (i, j);
        }
      }
    }
    return (0, 0);
  }
}

class Pipe {
  final String type;
  final int x;
  final int y;

  Pipe({required this.type, required this.x, required this.y});
}

extension PlusRecord on (int, int) {
  (int, int) plus((int, int) toAdd) => (this.$1 + toAdd.$1, this.$2 + toAdd.$2);
}

extension GridPos on List<List<String>> {
  String get((int, int) position) => this[position.$1][position.$2];
}
