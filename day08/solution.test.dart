import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 8', () {
    test('part1', () {
      expect(part1(fileName: "day08/input.example.txt"), equals(21));
      expect(part1(fileName: "day08/input.txt"), equals(1672));
    });

    test('part2', () {
      expect(part2(fileName: "day08/input.example.txt"), equals(8));
      expect(part2(fileName: "day08/input.txt"), equals(327180));
    });
  });
}
