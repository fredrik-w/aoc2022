import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 4', () {
    test('part1', () {
      expect(part1(fileName: "day04/input.example.txt"), equals(2));
      expect(part1(fileName: "day04/input.txt"), equals(560));
    });

    test('part2', () {
      expect(part2(fileName: "day04/input.example.txt"), equals(4));
      expect(part2(fileName: "day04/input.txt"), equals(839));
    });
  });
}
