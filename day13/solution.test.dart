import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 13', () {
    test('part1', () {
      expect(part1(fileName: "day13/input.example.txt"), equals(13));
      expect(part1(fileName: "day13/input.txt"), equals(5529));
    });

    test('part2', () {
      expect(part2(fileName: "day13/input.example.txt"), equals(140));
      expect(part2(fileName: "day13/input.txt"), equals(27690));
    });
  });
}
