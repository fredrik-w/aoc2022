import 'dart:io';

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

class Knot {
  int x;
  int y;

  Knot(this.x, this.y);

  toString() => "${x},${y}";
  equals(Knot other) => x == other.x && y == other.y;
}

Knot moveKnot(Knot head, Knot tail) {
  var x = tail.x, y = tail.y;
  var dx = head.x - tail.x, dy = head.y - tail.y;
  if (dy.abs() == 2) {
    y += 1 * dy.sign;
    if (dx.abs() > 0) x += 1 * dx.sign;
  } else if (dx.abs() == 2) {
    x += 1 * dx.sign;
    if (dy.abs() > 0) y += 1 * dy.sign;
  }
  return Knot(x, y);
}

int tail(List<String> lines, int knots) {
  var head = Knot(0, 0);
  var tails = List<Knot>.filled(knots, Knot(0, 0));
  var visited = Set<String>();

  lines.forEach((line) {
    var direction = line.split(" ").first;
    var steps = int.parse(line.split(" ").last);

    while (steps-- > 0) {
      if (direction == "R") {
        head.y++;
      } else if (direction == "L") {
        head.y--;
      } else if (direction == "U") {
        head.x++;
      } else if (direction == "D") {
        head.x--;
      }

      tails[0] = moveKnot(head, tails[0]);
      for (int i = 1; i < tails.length; i++) {
        var oldTails = tails[i];
        tails[i] = moveKnot(tails[i - 1], tails[i]);
        if (tails[i].equals(oldTails)) break;
      }

      visited.add(tails.last.toString());
    }
  });

  //print(visited);

  return visited.length;
}

num part1({String fileName = "input.txt"}) => tail(readFileToLines(fileName), 1);

num part2({String fileName = "input.txt"}) => tail(readFileToLines(fileName), 9);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
