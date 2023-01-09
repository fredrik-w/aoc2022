import 'dart:math';

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
