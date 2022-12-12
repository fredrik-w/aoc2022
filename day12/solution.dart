import 'dart:collection';
import 'dart:io';

extension AddIfMissing<T> on Set<T> {
  T addIfMissing(T n) => this.firstWhere((e) => e == n, orElse: () {
        this.add(n);
        return n;
      });
}

class Node {
  final int value;
  final int x;
  final int y;
  Node? parent = null;
  final Set<Node> edges = Set<Node>();

  Node(String value, this.x, this.y) : this.value = value.replaceFirst("S", "a").replaceFirst("E", "z").codeUnits.first;

  bool operator ==(Object other) => other is Node && other.x == this.x && other.y == this.y;
  @override
  int get hashCode => value * x * y;

  @override
  String toString() => "Node{value=${value} (${String.fromCharCode(value)}), x=${x}, y=${y}, [${edges.length}]}";
}

class Puzzle {
  final Set<Node> graph;
  final Node start;
  final Node end;

  const Puzzle(this.graph, this.start, this.end);
}

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

Iterable<Node> findNeighbours(List<String> lines, int x, int y) {
  return <Node>[
    if (x > 0) Node(lines[y][x - 1], x - 1, y),
    if (y > 0) Node(lines[y - 1][x], x, y - 1),
    if (x < lines[y].length - 1) Node(lines[y][x + 1], x + 1, y),
    if (y < lines.length - 1) Node(lines[y + 1][x], x, y + 1),
  ];
}

Puzzle graphInput(List<String> lines) {
  var nodes = Set<Node>(), start, end;
  for (int y = 0; y < lines.length; y++) {
    for (var line = lines[y], x = 0; x < line.length; x++) {
      var current = nodes.addIfMissing(Node(line[x], x, y));
      if (line[x] == "S") start = current;
      if (line[x] == "E") end = current;
      for (var neighbour in findNeighbours(lines, x, y)) {
        var n = nodes.addIfMissing(neighbour);
        current.edges.add(n);
        n.edges.add(current);
      }
    }
  }
  return Puzzle(nodes, start!, end!);
}

int bfsPath(Puzzle puzzle) {
  Set<Node> visited = Set();
  Queue<Node> queue = Queue();
  queue.add(puzzle.start);
  while (queue.isNotEmpty) {
    var v = queue.removeFirst();
    if (v == puzzle.end) {
      return pathCount(puzzle, v);
    }
    for (var w in v.edges) {
      if (w.value <= v.value + 1 && !visited.contains(w)) {
        visited.add(w);
        w.parent = v;
        queue.addLast(w);
      }
    }
  }
  return -1;
}

int pathCount(Puzzle puzzle, Node v) {
  int steps = 1;
  var current = v;
  while (current.parent != puzzle.start) {
    steps++;
    current = current.parent!;
  }
  return steps;
}

int shortestPathAnyA(Puzzle puzzle) {
  int shortest = double.maxFinite.toInt();
  puzzle.graph.where((n) => n.value == "a".codeUnits.first).forEach((a) {
    var length = bfsPath(Puzzle(puzzle.graph, a, puzzle.end));
    shortest = length != -1 && length < shortest ? length : shortest;
  });
  return shortest;
}

num part1({String fileName = "input.txt"}) => bfsPath(graphInput(readFileToLines(fileName)));

num part2({String fileName = "input.txt"}) => shortestPathAnyA(graphInput(readFileToLines(fileName)));

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
