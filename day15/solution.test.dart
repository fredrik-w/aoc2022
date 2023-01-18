import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 15', () {
    test('part1', () {
      expect(part1(fileName: "day15/input.example.txt", y: 10), equals(26));
      expect(part1(fileName: "day15/input.txt"), equals(4793062));
    });

    test('part2', () {
      expect(part2(fileName: "day15/input.example.txt", limit: 20), equals(56000011));
      expect(part2(fileName: "day15/input.txt"), equals(10826395253551));
    });
  });
}
