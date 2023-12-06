import 'package:aoc2023/advent_day.dart';
import 'package:aoc2023/util.dart';
import 'package:collection/collection.dart';

main() => Day5().solve();

class Day5 extends AdventDay {
  Day5() : super(5);

  @override
  part1(String input) {
    final parts = input.split("\n\n");
    final seeds = parts[0].replaceAll("seeds: ", "").split(' ').map(int.parse);
    final converters = parts.sublist(1).map(parseConverter);
    final locations = seeds.map((seed) => seedToLocation(seed, converters));
    return locations.min;
  }

  @override
  part2(String input) {
    final parts = input.split("\n\n");
    final seeds =
        parts[0].replaceAll("seeds: ", "").split(' ').map(int.parse).toList();
    final converters = parts.sublist(1).map(parseConverter);
    int min = 9007199254740991;
    for (int i = 0; i < seeds.length; i += 2) {
      for (int j = seeds[i]; j < seeds[i] + seeds[i + 1]; j++) {
        final l = seedToLocation(j, converters);
        if (l < min) {
          print('Found new min: $l');
          min = l;
        }
      }
    }
    return min;
  }

  int seedToLocation(int seed, Iterable<Converter> converters) {
    int v = seed;
    for (Converter c in converters) {
      v = c.convert(v);
    }
    return v;
  }

  Converter parseConverter(String input) {
    final rows = input.rows().sublist(1);
    final ranges = rows.map((e) {
      final values = e.split(" ");
      return Range(
          sourceStart: int.parse(values[1]),
          destinationStart: int.parse(values[0]),
          range: int.parse(values[2]));
    }).toList();
    return Converter(ranges: ranges);
  }
}

class Range {
  final int sourceStart;
  final int destinationStart;
  final int range;
  late final int sourceEnd;

  Range({
    required this.sourceStart,
    required this.destinationStart,
    required this.range,
  }) {
    sourceEnd = sourceStart + range;
  }
}

class Converter {
  final List<Range> ranges;

  Converter({required this.ranges});

  int convert(int value) {
    for (Range r in ranges) {
      if (value >= r.sourceStart && value < r.sourceEnd) {
        final dist = value - r.sourceStart;
        return r.destinationStart + dist;
      }
    }
    return value;
  }
}
