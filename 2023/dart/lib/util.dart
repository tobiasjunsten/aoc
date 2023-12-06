extension RowSplit on String {
  List<String> rows() {
    return this.split("\n");
  }
}
