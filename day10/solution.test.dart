import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 10', () {
    test('part1', () {
      expect(part1(fileName: "day10/input.example.txt"), equals(13140));
      expect(part1(fileName: "day10/input.txt"), equals(17020));
    });

    test('part2', () {
      expect(part2(fileName: "day10/input.example.txt"), equals(-2));
      expect(part2(fileName: "day10/input.txt"), equals(-2));
    });
  });
}
