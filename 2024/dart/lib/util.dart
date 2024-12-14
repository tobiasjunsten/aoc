import 'dart:math';

extension RowSplit on String {
  List<String> rows() {
    return split("\n");
  }

  List<List<String>> matrix() {
    return rows().map((e) => e.split("")).toList();
  }

  List<List<int>> intMatrix() {
    return rows()
        .map((e) => e.split("").map((e) => int.parse(e)).toList())
        .toList();
  }
}

extension MatrixUtil on List<List<String>> {
  String content(Point<int> point) {
    return this[point.y][point.x];
  }

  String? safeContent(Point<int> point) {
    if (point.inMatrix(this)) {
      return this[point.y][point.x];
    }
    return null;
  }
}

extension PointAddition on Point<int> {
  bool inMatrix(List<List<dynamic>> matrix) {
    return x >= 0 && x < matrix[0].length && y >= 0 && y < matrix.length;
  }

  Point<int> up() {
    return this + Point<int>(0, -1);
  }

  Point<int> right() {
    return this + Point<int>(1, 0);
  }

  Point<int> down() {
    return this + Point<int>(0, 1);
  }

  Point<int> left() {
    return this + Point<int>(-1, 0);
  }
}
