import 'package:aoc2024/util.dart';

import 'advent_day.dart';

main() => Day5().solve();

class Day5 extends AdventDay {
  Day5() : super(5);

  @override
  part1(String input) {
    final parts = input.split("\n\n");
    final rules = parts[0].rows();
    final ruleMap = generateRuleMap(rules);

    final updates = parts[1].rows();
    return updates.where((update) => correctOrder(ruleMap, update)).map((e) {
      var list = e.split(",");
      return int.parse(list[(list.length / 2).floor()]);
    }).reduce((a, b) => a + b);
  }

  Map<String, List<String>> generateRuleMap(List<String> rules) {
    Map<String, List<String>> ruleMap = {};

    for (var rule in rules) {
      final p = rule.split("|");
      final key = p[0];
      final value = p[1];

      if (ruleMap.containsKey(key)) {
        ruleMap[key]!.add(value);
      } else {
        ruleMap[key] = [value];
      }
    }
    return ruleMap;
  }

  bool correctOrder(Map<String, List<String>> rules, String update) {
    final updateParts = update.split(",");
    for (int i = 0; i < updateParts.length; i++) {
      final rule = rules[updateParts[i]];
      if (rule == null) {
        continue;
      }
      final listBefore = updateParts.sublist(0, i);
      for (var r in rule) {
        if (listBefore.contains(r)) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  part2(String input) {
    final parts = input.split("\n\n");
    final rules = parts[0].rows();
    final ruleMap = generateRuleMap(rules);

    final updates = parts[1].rows();
    final incorrectOrders =
        updates.where((update) => !correctOrder(ruleMap, update));
    final correctedOrders = incorrectOrders.map((order) {
      final parts = order.split(",");
      parts.sort((a, b) {
        final ruleA = ruleMap[a];
        final ruleB = ruleMap[b];
        if (ruleA == null && ruleB == null) {
          return 0;
        }
        if (ruleA!.contains(b)) {
          return 1;
        } else if (ruleB!.contains(a)) {
          return -1;
        }
        return 0;
      });
      return parts;
    });
    return correctedOrders
        .map((order) => int.parse(order[(order.length / 2).floor()]))
        .reduce((a, b) => a + b);
  }
}
