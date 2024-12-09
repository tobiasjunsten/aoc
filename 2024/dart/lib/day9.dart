import 'package:aoc2024/util.dart';

import 'advent_day.dart';

final testData = """
2333133121414131402""";

main() => Day9().solve();

class Day9 extends AdventDay {
  Day9() : super(9, testData: testData);

  @override
  part1(String input) {
    final numbers = input.split("").map((e) => int.parse(e)).toList();
    final l = generateMemory(numbers);
    final p = structureMemory(l);
    final checksum = calculateChecksum(p);
    return checksum;
  }

  int calculateChecksum(List<dynamic> l) {
    int sum = 0;
    for (int i = 0; i < l.length; i++) {
      if (l[i] == ".") {
        continue;
      }
      sum += i * l[i] as int;
    }
    return sum;
  }

  List<dynamic> structureMemory(List<dynamic> l) {
    int pos = 0;
    while (true) {
      if (pos >= l.length) {
        break;
      }
      final current = l[pos];
      if (current == ".") {
        final last = l.lastIndexWhere((element) => element != ".");
        if (last == -1 || last <= pos) {
          break;
        }
        l[pos] = l[last];
        l[last] = ".";
      }
      pos++;
    }
    return l;
  }

  List<dynamic> generateMemory(List<int> numbers) {
    var l = [];
    for (int i = 0; i < (numbers.length / 2); i++) {
      final fileNumer = i;
      final index = i * 2;
      final emptyIndex = index + 1;
      final fileLength = numbers[index];
      final emptyLength =
          emptyIndex >= numbers.length ? 0 : numbers[emptyIndex];
      final fileContent = List.filled(fileLength, fileNumer);
      final emptyContent = List.filled(emptyLength, ".");
      l.addAll(fileContent);
      l.addAll(emptyContent);
    }
    return l;
  }

  @override
  part2(String input) {
    final numbers = input.split("").map((e) => int.parse(e)).toList();
    final l = generateMemoryModel(numbers);
    final p = structureMemoryModel(l);
    final memory = p
        .expand((e) => e is File
            ? List.filled(e.length, e.number)
            : List.filled(e.length, "."))
        .toList();
    print(memory.join(""));
    return calculateChecksum(memory);
  }

  List<MemoryElement> generateMemoryModel(List<int> numbers) {
    var memory = <MemoryElement>[];
    for (int i = 0; i < (numbers.length / 2); i++) {
      final fileNumer = i;
      final index = i * 2;
      final emptyIndex = index + 1;
      final fileLength = numbers[index];
      final emptyLength =
          emptyIndex >= numbers.length ? 0 : numbers[emptyIndex];
      memory.add(File(fileLength, fileNumer));
      memory.add(Empty(emptyLength));
    }
    return memory;
  }

  List<MemoryElement> structureMemoryModel(List<MemoryElement> memory) {
    final files = memory.whereType<File>().toList().reversed;
    final structuredMemory = <MemoryElement>[...memory];
    for (final file in files) {
      final emptyIndex = structuredMemory
          .indexWhere((e) => e is Empty && e.length >= file.length);
      final fileIndex = structuredMemory
          .lastIndexWhere((e) => e is File && e.number == file.number);
      if (emptyIndex >= 0 && emptyIndex < fileIndex) {
        // Insert file at empty index
        structuredMemory.insert(emptyIndex, file);
        // Decrease empty length
        structuredMemory[emptyIndex + 1] = Empty(
            (structuredMemory[emptyIndex + 1] as Empty).length - file.length);
        // Replace old file with empty
        structuredMemory[fileIndex + 1] = Empty(file.length);
      }
    }
    return structuredMemory;
  }
}

abstract class MemoryElement {
  int length;
  MemoryElement(this.length);
}

class File extends MemoryElement {
  int number;
  File(super.length, this.number);
}

class Empty extends MemoryElement {
  Empty(super.length);
}
