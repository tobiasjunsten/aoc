import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';
import 'package:collection/collection.dart';

main() => Day3().solve();

class Day3 extends AdventDay {
  Day3() : super(3);

  @override
  part1(String input) {
    final p = parseSchema(input);
    final List<Symbol> symbols = p.where((e) => e is Symbol).toList().cast();
    final List<Number> numbers = p.where((e) => e is Number).toList().cast();
    return numbers
        .where((n) => symbols.any((s) => n.adjacentToSymbol(s)))
        .map((e) => e.number)
        .sum;
  }

  @override
  part2(String input) {
    final p = parseSchema(input);
    final List<Symbol> symbols = p.where((e) => e is Symbol).toList().cast();
    final List<Number> numbers = p.where((e) => e is Number).toList().cast();
    final gears = symbols.where((s) => s.symbol == '*').map((e) {
      final adjacentNumbers =
          numbers.where((n) => n.adjacentToSymbol(e)).toList();
      if (adjacentNumbers.length == 2) {
        return adjacentNumbers[0].number * adjacentNumbers[1].number;
      }
      return 0;
    });
    return gears.sum;
  }

  List<SchemaEntity> parseSchema(String input) {
    final numberRegex = RegExp('[0-9]+');
    final symbolRegex = RegExp('[^0-9.]');
    var rowNumber = 0;
    return input.rows().expand((row) {
      final matches = numberRegex.allMatches(row);
      final numbers = matches.map((m) => Number(
            startColumn: m.start,
            endColumn: m.end,
            number: int.parse(row.substring(m.start, m.end)),
            row: rowNumber,
          ));
      final symbolMatches = symbolRegex.allMatches(row);
      final symbols = symbolMatches.map((m) => Symbol(
          row: rowNumber,
          column: m.start,
          symbol: row.substring(m.start, m.end)));
      rowNumber++;
      return [...numbers, ...symbols];
    }).toList();
  }
}

interface class SchemaEntity {}

class Number implements SchemaEntity {
  final int row;
  final int number;
  final int startColumn;
  final int endColumn;

  Number({
    required this.row,
    required this.number,
    required this.startColumn,
    required this.endColumn,
  });

  bool adjacentToSymbol(Symbol s) {
    return s.row >= row - 1 &&
        s.row <= row + 1 &&
        s.column >= startColumn - 1 &&
        s.column <= endColumn;
  }
}

class Symbol implements SchemaEntity {
  final String symbol;
  final int row;
  final int column;

  Symbol({required this.row, required this.column, required this.symbol});
}
