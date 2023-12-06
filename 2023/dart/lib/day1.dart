import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';
import 'package:collection/collection.dart';

main() => Day1().solve();

class Day1 extends AdventDay {
  Day1() : super(1);

  dynamic part1(String input) {
    return getSum(input.rows());
  }

  dynamic part2(String input) {
    final rows = input.rows().map(convertTextNumbersToDigits).toList();
    return getSum(rows);
  }

  dynamic getSum(List<String> rows) {
    final onlyDigits = rows.map(
        (row) => row.split("").where((c) => int.tryParse(c) != null).toList());
    final numbers = onlyDigits.map((e) => e.first + e.last).map(int.parse);
    return numbers.sum;
  }

  String convertTextNumbersToDigits(String input) {
    final one = getIndexNum("one", 1, input);
    final two = getIndexNum("two", 2, input);
    final three = getIndexNum("three", 3, input);
    final four = getIndexNum("four", 4, input);
    final five = getIndexNum("five", 5, input);
    final six = getIndexNum("six", 6, input);
    final seven = getIndexNum("seven", 7, input);
    final eight = getIndexNum("eight", 8, input);
    final nine = getIndexNum("nine", 9, input);

    List<IndexNum> all = [one, two, three, four, five, six, seven, eight, nine];
    final foundFirst = all.where((element) => element.firstIndex >= 0).toList();
    foundFirst.sort((a, b) => a.firstIndex.compareTo(b.firstIndex));
    if (foundFirst.length > 0) {
      input = input.replaceRange(foundFirst.first.firstIndex,
          foundFirst.first.firstIndex, foundFirst.first.number.toString());
    }

    final foundLast = all.where((element) => element.lastIndex >= 0).toList();
    foundLast.sort((a, b) => b.lastIndex.compareTo(a.lastIndex));
    if (foundLast.length > 0) {
      input = input.replaceRange(foundLast.first.lastIndex + 1,
          foundLast.first.lastIndex + 1, foundLast.first.number.toString());
    }
    return input;
  }

  IndexNum getIndexNum(String text, int digit, String input) {
    final firstIndex = input.indexOf(text);
    final lastIndex = input.lastIndexOf(text);
    return IndexNum(
        firstIndex: firstIndex, num: text, number: digit, lastIndex: lastIndex);
  }
}

class IndexNum {
  final int firstIndex;
  final String num;
  final int number;
  final int lastIndex;

  IndexNum(
      {required this.firstIndex,
      required this.num,
      required this.number,
      required this.lastIndex});
}
