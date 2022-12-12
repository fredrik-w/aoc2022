import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 12', () {
    test('part1', () {
      expect(part1(fileName: "day12/input.example.txt"), equals(31));
      expect(part1(fileName: "day12/input.txt"), equals(425));
    });

    test('part2', () {
      expect(part2(fileName: "day12/input.example.txt"), equals(29));
      expect(part2(fileName: "day12/input.txt"), equals(418));
    });
  });
}
