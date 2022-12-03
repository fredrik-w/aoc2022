import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 3', () {
    test('part1', () {
      expect(part1(fileName: "day03/input.example.txt"), equals(157));
      expect(part1(fileName: "day03/input.txt"), equals(7766));
    });

    test('part2', () {
      expect(part2(fileName: "day03/input.example.txt"), equals(70));
      expect(part2(fileName: "day03/input.txt"), equals(2415));
    });
  });
}
