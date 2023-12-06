import 'dart:math';

import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';
import 'package:collection/collection.dart';

main() => Day4().solve();

class Day4 extends AdventDay {
  Day4() : super(4);

  @override
  part1(String input) {
    return cardPoints(input).sum;
  }

  @override
  part2(String input) {
    final points = parseWinning(input);
    final copies = Map<int, int>();
    var totalCopies = 0;
    for (int i = 0; i < points.length; i++) {
      final currentPoints = points[i];
      final currentCopies = (copies[i] ?? 0);
      final numberOfCards = currentCopies + 1;
      totalCopies += numberOfCards;
      for (int j = 1; j <= currentPoints; j++) {
        final newCopies = (copies[i + j] ?? 0) + numberOfCards;
        copies[i + j] = newCopies;
      }
    }
    return totalCopies;
  }

  List<int> parseWinning(String input) {
    return input.rows().map((e) {
      final cards = e.split(": ")[1].split(" | ");
      final winningCards =
          cards[0].split(" ").where((e) => e.trim().length > 0);
      final myCards = cards[1].split(" ").where((e) => e.trim().length > 0);
      final myWinning = winningCards.toSet().intersection(myCards.toSet());
      return myWinning.length;
    }).toList();
  }

  List<int> cardPoints(String input) {
    return parseWinning(input).map((e) {
      if (e == 0) {
        return 0;
      }
      return pow(2, e - 1).toInt();
    }).toList();
  }
}
