import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 11', () {
    test('part1', () {
      expect(part1(fileName: "day11/input.example.txt"), equals(10605));
      expect(part1(fileName: "day11/input.txt"), equals(64032));
    });

    test('part2', () {
      expect(part2(fileName: "day11/input.example.txt"), equals(2713310158));
      expect(part2(fileName: "day11/input.txt"), equals(12729522272));
    });
  });
}
