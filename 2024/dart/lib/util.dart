extension RowSplit on String {
  List<String> rows() {
    return split("\n");
  }

  List<List<String>> matrix() {
    return rows().map((e) => e.split("")).toList();
  }
}
