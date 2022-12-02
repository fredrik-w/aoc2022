import 'dart:io';

List<int> elfCalories(String fileName) {
  var input = File.fromUri(Uri.file(fileName)).readAsLinesSync();

  var elfs = input.fold(<int>[0], (elfs, calories) {
    if (calories == "") {
      return elfs..add(0);
    }
    elfs[elfs.length - 1] += int.parse(calories);
    return elfs;
  });
  return elfs..sort((a, b) => a.compareTo(b));
}

num part1({String fileName = "input.txt"}) => elfCalories(fileName).last;

num part2({String fileName = "input.txt"}) {
  var elfs = elfCalories(fileName);
  return elfs.sublist(elfs.length - 3).reduce((sum, curr) => sum += curr);
}

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
