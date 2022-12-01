import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 1', () {
    test('part1', () {
      expect(part1("day01/input.example.txt"), equals(24000));
      expect(part1("day01/input.txt"), equals(75501));
    });

    test('part2', () {
      expect(part2("day01/input.example.txt"), equals(45000));
      expect(part2("day01/input.txt"), equals(215594));
    });
  });
}
