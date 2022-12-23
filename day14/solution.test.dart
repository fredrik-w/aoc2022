import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 14', () {
    test('part1', () {
      expect(part1(fileName: "day14/input.example.txt"), equals(24));
      expect(part1(fileName: "day14/input.txt"), equals(1406));
    });

    test('part2', () {
      expect(part2(fileName: "day14/input.example.txt"), equals(-2));
      expect(part2(fileName: "day14/input.txt"), equals(-2));
    });
  });
}
