import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 2', () {
    test('part1', () {
      expect(part1(fileName: "day02/input.example.txt"), equals(15));
      expect(part1(fileName: "day02/input.txt"), equals(9759));
    });

    test('part2', () {
      expect(part2(fileName: "day02/input.example.txt"), equals(12));
      expect(part2(fileName: "day02/input.txt"), equals(12429));
    });
  });
}
