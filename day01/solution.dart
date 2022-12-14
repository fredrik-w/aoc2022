import 'dart:io';

List<String> readFileAsLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<int> elfCalories(List<String> lines) => lines.fold(<int>[0], (elfs, calories) {
      if (calories == "") return elfs..add(0);
      return elfs..last += int.parse(calories);
    })
      ..sort((a, b) => a.compareTo(b));

num part1({String fileName = "input.txt"}) => elfCalories(readFileAsLines(fileName)).last;

num part2({String fileName = "input.txt"}) =>
    elfCalories(readFileAsLines(fileName)).reversed.take(3).reduce((sum, curr) => sum + curr);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
