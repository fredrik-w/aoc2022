import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 15', () {
    test('part1', () {
      expect(part1(fileName: "day15/input.example.txt", y: 10), equals(26));
      expect(part1(fileName: "day15/input.txt"), equals(4793062));
    });

    test('part2', () {
      expect(part2(fileName: "day15/input.example.txt"), equals(-2));
      expect(part2(fileName: "day15/input.txt"), equals(-2));
    });
  });
}
