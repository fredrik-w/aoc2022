import 'package:test/test.dart';

import 'solution.dart';

void main() {
  group('AoC 2022: day 6', () {
    test('part1', () {
      expect(part1(fileName: "day06/input.example.txt"), equals(7));
      expect(findMarkerStart("bvwbjplbgvbhsrlpgdmjqwftvncz", 4), equals(5));
      expect(findMarkerStart("nppdvjthqldpwncqszvftbrmjlhg", 4), equals(6));
      expect(findMarkerStart("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 4), equals(10));
      expect(findMarkerStart("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 4), equals(11));
      expect(part1(fileName: "day06/input.txt"), equals(1625));
    });

    test('part2', () {
      expect(part2(fileName: "day06/input.example.txt"), equals(19));
      expect(findMarkerStart("bvwbjplbgvbhsrlpgdmjqwftvncz", 14), equals(23));
      expect(findMarkerStart("nppdvjthqldpwncqszvftbrmjlhg", 14), equals(23));
      expect(findMarkerStart("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 14), equals(29));
      expect(findMarkerStart("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 14), equals(26));
      expect(part2(fileName: "day06/input.txt"), equals(2250));
    });
  });
}
