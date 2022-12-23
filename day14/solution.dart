import 'dart:io';
import 'dart:math';

class Puzzle {
  final Map<int, List<String>> cave;
  final int maxDepth;

  const Puzzle(this.cave, this.maxDepth);
}

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

Point<int> parsePosition(String pos) => Point(int.parse(pos.split(",").first), int.parse(pos.split(",").last));

List<String> addOrExpandColumn(Map<int, List<String>> cave, int size, int x) {
  var l = cave.putIfAbsent(x, () => List.filled(size, ".", growable: true));
  if (l.length < size) l.addAll(List.filled(size - l.length, "."));
  return l;
}

Puzzle parse(List<String> rocks) {
  Map<int, List<String>> cave = {};

  rocks.map((r) => r.split(" -> ")).forEach((positions) {
    for (int i = 1; i < positions.length; i++) {
      var start = parsePosition(positions[i - 1]), end = parsePosition(positions[i]);
      if (start.x == end.x)
        addOrExpandColumn(cave, max(end.y, start.y) + 1, start.x)
            .fillRange(min(start.y, end.y), max(start.y, end.y) + 1, "#");
      else
        List<int>.generate((end.x - start.x).abs() + 1, (index) => index + min(start.x, end.x))
            .forEach((x) => addOrExpandColumn(cave, start.y + 1, x)[start.y] = "#");
    }
  });
  var maxDepth = cave.values.map((list) => list.length).reduce((deepest, depth) => max(depth, deepest));
  var keys = cave.keys.toList()..sort((a, b) => a - b);
  cave
    ..putIfAbsent(keys.first - 1, () => [])
    ..putIfAbsent(keys.last + 1, () => [])
    ..forEach((x, value) => value.addAll(List.filled(maxDepth - value.length, ".")));

  return Puzzle(cave, maxDepth);
}

num simulateSand(Puzzle puzzle) {
  var cave = puzzle.cave;
  // var keys = puzzle.cave.keys.toList()..sort((a, b) => a - b);
  bool done = false;
  while (!done) {
    bool atRest = false;
    Point<int> current = Point(500, 0);
    while (!atRest) {
      // if (current.x == keys.first || current.x == keys.last) {
      //   done = true;
      //   break;
      // }
      // day14PrintCave(cave, puzzle.maxDepth, current: current);
      var start = current;

      var yDrop = cave[current.x]!.sublist(current.y).indexWhere((c) => c != ".") - 1;
      // if (yDrop > 0) current += Point(0, yDrop);
      current += Point(0, max(0, yDrop));
      if (current.y + 1 >= puzzle.maxDepth) {
        done = true;
        break;
      }
      if (cave[current.x - 1]?[current.y + 1] == ".") {
        current += Point<int>(-1, 1);
      } else if (cave[current.x + 1]?[current.y + 1] == ".") {
        current += Point<int>(1, 1);
      }
      atRest = current == start;
      if (atRest) cave[current.x]![current.y] = "o";
      // if (atRest) day14PrintCave(cave, puzzle.maxDepth, current: current);
    }
  }
  return cave.values.map((l) => l.where((e) => e == "o").length).reduce((sum, v) => sum + v);
}

num part1({String fileName = "input.txt"}) => simulateSand(parse(readFileToLines(fileName)));

num part2({String fileName = "input.txt"}) => -2;

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
