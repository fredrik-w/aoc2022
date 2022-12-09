import 'dart:io';

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

class RopeEnd {
  int x;
  int y;

  RopeEnd(this.x, this.y);

  toString() => "${x},${y}";
}

int tail(List<String> lines) {
  var head = RopeEnd(0, 0);
  var tail = RopeEnd(0, 0);
  var visited = Set<String>();

  lines.forEach((line) {
    var direction = line.split(" ").first;
    var steps = int.parse(line.split(" ").last);

    //for (int i = 0; i < steps; i++) {
    while (steps-- > 0) {
      if (direction == "R") {
        head.y += 1;
      } else if (direction == "L") {
        head.y -= 1;
      } else if (direction == "U") {
        head.x += 1;
      } else if (direction == "D") {
        head.x -= 1;
      }

      if ((head.x - tail.x) == 2) {
        tail.x += 1;
        tail.y = head.y;
      }
      if ((head.x - tail.x) == -2) {
        tail.x -= 1;
        tail.y = head.y;
      }
      if ((head.y - tail.y) == 2) {
        tail.y += 1;
        tail.x = head.x;
      }
      if ((head.y - tail.y) == -2) {
        tail.y -= 1;
        tail.x = head.x;
      }
      visited.add(tail.toString());
    }
  });

  return visited.length;
}

num part1({String fileName = "input.txt"}) => tail(readFileToLines(fileName));

num part2({String fileName = "input.txt"}) => -2;

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
