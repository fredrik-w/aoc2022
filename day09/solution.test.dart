import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 9', () {
    test('part1', () {
      expect(part1(fileName: "day09/input.example.txt"), equals(13));
      expect(part1(fileName: "day09/input.txt"), equals(-1));
    });

    test('part2', () {
      expect(part2(fileName: "day09/input.example.txt"), equals(-2));
      expect(part2(fileName: "day09/input.txt"), equals(-2));
    });
  });
}
