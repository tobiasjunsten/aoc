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

extension PointAddition on Point {
  bool inMatrix(List<List<dynamic>> matrix) {
    return x >= 0 && x < matrix[0].length && y >= 0 && y < matrix.length;
  }
}
