import 'dart:io';
import 'dart:math' show max;

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<List<int>> parseTrees(List<String> lines) =>
    lines.map((line) => line.split("").map((c) => int.parse(c)).toList()).toList();

int highestInLine(List<int> trees) => trees.reduce((highest, tree) => max(highest, tree));

List<int> getColumn(List<List<int>> trees, int col) => trees.map((treeLine) => treeLine[col]).toList();

int visibleInLine(List<int> trees, int maxHeight) {
  var count = trees.indexWhere((tree) => tree >= maxHeight);
  return count == -1 ? trees.length : count + 1;
}

int countVisibleTrees(List<List<int>> forest) {
  int visibleTrees = forest[0].length + forest[forest.length - 1].length + (forest.length - 2) * 2;
  for (int row = 1; row < forest.length - 1; row++) {
    for (var treeLine = forest[row], col = 1; col < treeLine.length - 1; col++) {
      if (highestInLine(treeLine.sublist(0, col)) < treeLine[col] ||
          highestInLine(treeLine.sublist(col + 1)) < treeLine[col] ||
          highestInLine(getColumn(forest.sublist(0, row), col)) < treeLine[col] ||
          highestInLine(getColumn(forest.sublist(row + 1), col)) < treeLine[col]) {
        visibleTrees++;
        continue;
      }
    }
  }
  return visibleTrees;
}

int calculateScenicScore(List<List<int>> forest) {
  int scenicScore = 0;
  for (int row = 0; row < forest.length; row++) {
    for (var treeLine = forest[row], col = 0; col < treeLine.length; col++) {
      var visibleTrees = [
        visibleInLine(getColumn(forest.sublist(0, row), col).reversed.toList(), treeLine[col]),
        visibleInLine(treeLine.sublist(0, col).reversed.toList(), treeLine[col]),
        visibleInLine(treeLine.sublist(col + 1), treeLine[col]),
        visibleInLine(getColumn(forest.sublist(row + 1), col), treeLine[col]),
      ];
      scenicScore = max(visibleTrees.reduce((sum, val) => sum *= val), scenicScore);
    }
  }
  return scenicScore;
}

num part1({String fileName = "input.txt"}) => countVisibleTrees(parseTrees(readFileToLines(fileName)));

num part2({String fileName = "input.txt"}) => calculateScenicScore(parseTrees(readFileToLines(fileName)));

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
