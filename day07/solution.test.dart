import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 7', () {
    test('part1', () {
      expect(part1(fileName: "day07/input.example.txt"), equals(95437));
      expect(part1(fileName: "day07/input.txt"), equals(1477771));
    });

    test('part2', () {
      expect(part2(fileName: "day07/input.example.txt"), equals(24933642));
      expect(part2(fileName: "day07/input.txt"), equals(3579501));
    });
  });
}
