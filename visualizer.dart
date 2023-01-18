import 'dart:math';

import 'day15/solution.dart';

void day14PrintCave(Map<int, List<String>> cave, int maxDepth, {Point? current}) {
  var keys = cave.keys.toList()..sort((a, b) => a - b);
  var lines = [];
  for (int y = 0; y < maxDepth; y++) {
    lines.add(keys
        .map((x) => x == 500 && y == 0
            ? "+"
            : current?.x == x && current?.y == y
                ? 'c'
                : cave[x]![y])
        .join(""));
  }
  print(lines.join("\n"));
}

void day15PrintReport(Iterable<SensorBeacon> report) {
  var minX = report.fold(0, (val, p) => min(val, p.distance));
  var maxX = report.fold(0, (val, p) => max(val, p.distance));
  var minY = report.fold(0, (val, p) => min(val, p.distance));
  var maxY = report.fold(0, (val, p) => max(val, p.distance));
  var sensors = report.map((r) => r.sensor);
  var beacons = report.map((r) => r.beacon);

  List<String> lines = [];
  for (int y = minY; y <= maxY; y++) {
    var line = <String>[];
    var coverage = report.map((r) => r.coverageOnLine(y)).expand((list) => list);
    for (int x = minX; x <= maxX; x++) {
      var point = Point(x, y);
      if (beacons.contains(point)) {
        line.add("B");
      } else if (sensors.contains(point)) {
        line.add("S");
      } else if (coverage.contains(x)) {
        line.add("#");
      } else {
        line.add(".");
      }
    }
    lines.add(line.join());
  }
  print(lines.join("\n"));
}
