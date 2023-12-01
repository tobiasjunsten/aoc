import 'package:aoc2023/advent_day.dart';
import 'package:collection/collection.dart';

main() => Day1().solve();

class Day1 extends AdventDay {
  Day1() : super(1);

  String part1(String input) {
    final a = "onetwothreefour";
    print(convertToDigits(a));
    final rows = input.split("\n");
    return getSum(rows);
  }

  String part2(String input) {
    final rows = input.split("\n").map(convertToDigits).toList();
    return getSum(rows);
  }

  String getSum(List<String> rows) {
    final onlyDigits = rows
        .map((row) =>
            row.split("").where((c) => int.tryParse(c) != null).toList())
        .where((element) => element.length > 0);
    final numbers = onlyDigits.map((e) => e.first + e.last);
    final nums = numbers.map(int.parse);
    final sum = nums.sum;
    return sum.toString();
  }

  String convertToDigits(String input) {
    final one = input.indexOf("one");
    final indOne = IndexNum(index: one, num: "one", number: 1);
    final two = input.indexOf("two");
    final indTwo = IndexNum(index: two, num: "two", number: 2);
    final three = input.indexOf("three");
    final indThree = IndexNum(index: three, num: "three", number: 3);
    final four = input.indexOf("four");
    final indFour = IndexNum(index: four, num: "four", number: 4);
    final five = input.indexOf("five");
    final indFive = IndexNum(index: five, num: "five", number: 5);
    final six = input.indexOf("six");
    final indSix = IndexNum(index: six, num: "six", number: 6);
    final seven = input.indexOf("seven");
    final indSeven = IndexNum(index: seven, num: "seven", number: 7);
    final eight = input.indexOf("eight");
    final indEight = IndexNum(index: eight, num: "eight", number: 8);
    final nine = input.indexOf("nine");
    final indNine = IndexNum(index: nine, num: "nine", number: 9);
    List<IndexNum> all = [
      indOne,
      indTwo,
      indThree,
      indFour,
      indFive,
      indSix,
      indSeven,
      indEight,
      indNine
    ];
    final found = all.where((element) => element.index > 0).toList();
    found.sort((a, b) => a.index.compareTo(b.index));
    if (found.length > 0) {
      return input
          .replaceRange(found.first.index, found.first.index,
              found.first.number.toString())
          .replaceRange(found.last.index + 1, found.last.index + 1,
              found.last.number.toString());
    }
    return input;
  }
}

class IndexNum {
  final int index;
  final String num;
  final int number;

  IndexNum({required this.index, required this.num, required this.number});
}
