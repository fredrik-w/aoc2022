import 'dart:io';

List<int> elfCalories(String fileName) {
  var input = File.fromUri(Uri.file(fileName)).readAsLinesSync();

  var elfs = <int>[0];
  input.fold(elfs, (elfs, calories) {
    if (calories == "") {
      elfs.add(0);
    } else {
      elfs[elfs.length - 1] += int.parse(calories);
    }
    return elfs;
  });
  elfs.sort((a, b) => a.compareTo(b));
  return elfs;
}

num part1({String fileName = "input.txt"}) => elfCalories(fileName).last;

num part2({String fileName = "input.txt"}) {
  var elfs = elfCalories(fileName);
  return elfs.sublist(elfs.length - 3).reduce((sum, curr) => sum += curr);
}

void main(List<String> arguments) {
  exitCode = 0;
  stdout.write((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
}
