import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 5', () {
    test('part1', () {
      expect(part1(fileName: "day05/input.example.txt"), equals("CMZ"));
      expect(part1(fileName: "day05/input.txt"), equals("ZSQVCCJLL"));
    });

    test('part2', () {
      expect(part2(fileName: "day05/input.example.txt"), equals("MCD"));
      expect(part2(fileName: "day05/input.txt"), equals("QZFJRWHGS"));
    });
  });
}
