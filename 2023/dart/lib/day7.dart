import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';
import 'package:collection/collection.dart';

main() => Day7().solve();

class Day7 extends AdventDay {
  Day7() : super(7);

  @override
  part1(String input) {
    final hands = input.rows().map(generateHand).toList();
    hands.sort((a, b) => b.compareTo(a));
    return hands
        .asMap()
        .entries
        .map((hand) => hand.value.bid * (hand.key + 1))
        .toList()
        .sum;
  }

  @override
  part2(String input) {
    final hands =
        input.rows().map((row) => generateHand(row, part2: true)).toList();
    hands.sort((a, b) => b.compareTo(a));
    return hands
        .asMap()
        .entries
        .map((hand) => hand.value.bid * (hand.key + 1))
        .toList()
        .sum;
  }

  Hand generateHand(String handRow, {bool part2 = false}) {
    final parts = handRow.split(" ");
    final bid = int.parse(parts[1]);
    final cards = parts[0];
    final jackSort = part2 ? "N" : "D";
    final sortCards = cards
        .replaceAll("A", "A")
        .replaceAll("K", "B")
        .replaceAll("Q", "C")
        .replaceAll("J", jackSort)
        .replaceAll("T", "E")
        .replaceAll("9", "F")
        .replaceAll("8", "G")
        .replaceAll("7", "H")
        .replaceAll("6", "I")
        .replaceAll("5", "J")
        .replaceAll("4", "K")
        .replaceAll("3", "L")
        .replaceAll("2", "M");

    final tmpHand = cards.replaceAll('J', '');
    final tmpGroups = tmpHand.split('').groupListsBy((e) => e);
    String valueHand = cards;
    if (part2) {
      if (tmpHand.isEmpty) {
        valueHand = "JJJJJ";
      } else {
        int m = 0;
        String a = '';
        for (final g in tmpGroups.keys) {
          final l = tmpGroups[g];
          if (l!.length > m) {
            m = l.length;
            a = g;
          }
        }
        valueHand = cards.replaceAll("J", a);
      }
    }

    final cardGroups = valueHand
        .split('')
        .groupListsBy((e) => e)
        .values
        .map((e) => e.length)
        .toList()
      ..sort();
    final HandType handType;
    if (cardGroups.equals([5])) {
      handType = HandType.FIVE;
    } else if (cardGroups.equals([1, 4])) {
      handType = HandType.FOUR;
    } else if (cardGroups.equals([2, 3])) {
      handType = HandType.FULL;
    } else if (cardGroups.equals([1, 1, 3])) {
      handType = HandType.THREE;
    } else if (cardGroups.equals([1, 2, 2])) {
      handType = HandType.TWO;
    } else if (cardGroups.equals([1, 1, 1, 2])) {
      handType = HandType.ONE;
    } else {
      handType = HandType.HIGH;
    }
    return Hand(
        bid: bid,
        originalCards: cards,
        handType: handType,
        sortCards: sortCards);
  }
}

class Hand {
  final int bid;
  final String originalCards;
  final HandType handType;
  final String sortCards;

  Hand(
      {required this.bid,
      required this.originalCards,
      required this.handType,
      required this.sortCards});
}

enum HandType { FIVE, FOUR, FULL, THREE, TWO, ONE, HIGH }

extension on HandType {
  int compareTo(HandType other) => this.index.compareTo(other.index);
}

extension on Hand {
  int compareTo(Hand other) {
    final ht = this.handType.compareTo(other.handType);
    if (ht == 0) {
      return this.sortCards.compareTo(other.sortCards);
    }
    return ht;
  }
}
