import 'package:aoc2023/advent_day.dart';
import 'package:collection/collection.dart';

main() => Day1().solve();

class Day1 extends AdventDay {
  Day1() : super(1);

  dynamic part1(String input) {
    final rows = input.split("\n");
    return getSum(rows);
  }

  dynamic part2(String input) {
    final rows = input.split("\n").map(convertTextNumbersToDigits).toList();
    return getSum(rows);
  }

  dynamic getSum(List<String> rows) {
    final onlyDigits = rows.where((row) => row.length > 0)
        .map((row) =>
            row.split("").where((c) => int.tryParse(c) != null).toList());
    final numbers = onlyDigits.map((e) => e.first + e.last).map(int.parse);
    return numbers.sum;
  }

  String convertTextNumbersToDigits(String input) {
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
    final found = all.where((element) => element.index >= 0).toList();
    found.sort((a, b) => a.index.compareTo(b.index));
    if (found.length > 0) {
      input = input
          .replaceRange(found.first.index, found.first.index,
              found.first.number.toString());
    }

    final onex = input.lastIndexOf("one");
    final indOnex = IndexNum(index: onex, num: "one", number: 1);
    final twox = input.lastIndexOf("two");
    final indTwox = IndexNum(index: twox, num: "two", number: 2);
    final threex = input.lastIndexOf("three");
    final indThreex = IndexNum(index: threex, num: "three", number: 3);
    final fourx = input.lastIndexOf("four");
    final indFourx = IndexNum(index: fourx, num: "four", number: 4);
    final fivex = input.lastIndexOf("five");
    final indFivex = IndexNum(index: fivex, num: "five", number: 5);
    final sixx = input.lastIndexOf("six");
    final indSixx = IndexNum(index: sixx, num: "six", number: 6);
    final sevenx = input.lastIndexOf("seven");
    final indSevenx = IndexNum(index: sevenx, num: "seven", number: 7);
    final eightx = input.lastIndexOf("eight");
    final indEightx = IndexNum(index: eightx, num: "eight", number: 8);
    final ninex = input.lastIndexOf("nine");
    final indNinex = IndexNum(index: ninex, num: "nine", number: 9);
    List<IndexNum> allx = [
      indOnex,
      indTwox,
      indThreex,
      indFourx,
      indFivex,
      indSixx,
      indSevenx,
      indEightx,
      indNinex
    ];
    final foundx = allx.where((element) => element.index >= 0).toList();
    foundx.sort((a, b) => b.index.compareTo(a.index));
    if (foundx.length > 0) {
      input = input
          .replaceRange(foundx.first.index, foundx.first.index,
              foundx.first.number.toString());
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
