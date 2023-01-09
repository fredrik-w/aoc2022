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
  var column = cave.putIfAbsent(x, () => List.filled(size, ".", growable: true));
  if (column.length < size) column.addAll(List.filled(size - column.length, "."));
  return column;
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

num simulateSand(Puzzle puzzle, bool Function(Puzzle, Point) isDone, {bool addColumns = false}) {
  var cave = puzzle.cave;
  bool done = false;
  while (!done) {
    bool atRest = false;
    Point<int> current = Point(500, 0);
    while (!atRest && !done) {
      var start = current;

      current += Point(0, max(0, cave[current.x]!.sublist(current.y).indexWhere((c) => c != ".") - 1));
      if (addColumns) {
        addOrExpandColumn(cave, puzzle.maxDepth, current.x - 1).last = "#";
        addOrExpandColumn(cave, puzzle.maxDepth, current.x + 1).last = "#";
      }
      if (cave[current.x - 1]?[current.y + 1] == ".")
        current += Point<int>(-1, 1);
      else if (cave[current.x + 1]?[current.y + 1] == ".") current += Point<int>(1, 1);
      if ((atRest = current == start)) cave[current.x]![current.y] = "o";
      if (isDone(puzzle, current)) done = true;
    }
  }
  return cave.values.map((l) => l.where((e) => e == "o").length).reduce((sum, v) => sum + v);
}

Puzzle addFloor(Puzzle puzzle) => Puzzle(
    puzzle.cave..keys.forEach((x) => addOrExpandColumn(puzzle.cave, puzzle.maxDepth + 2, x).last = "#"),
    puzzle.maxDepth + 2);

num part1({String fileName = "input.txt"}) =>
    simulateSand(parse(readFileToLines(fileName)), (puzzle, current) => current.y + 1 >= puzzle.maxDepth);

num part2({String fileName = "input.txt"}) =>
    simulateSand(addFloor(parse(readFileToLines(fileName))), (puzzle, current) => current == Point(500, 0),
        addColumns: true);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
