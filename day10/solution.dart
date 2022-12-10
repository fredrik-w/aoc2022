import 'dart:io';

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<int> cycles(List<String> instructions) {
  List<int> register = <int>[1];

  instructions.forEach((inst) {
    register.add(register.last);
    if (inst.startsWith("addx")) register.add(register.last + int.parse(inst.split(" ").last));
  });

  return register;
}

int signalStrength(List<int> cycles) =>
    [20, 60, 100, 140, 180, 220].map((cycle) => cycle * cycles[cycle - 1]).reduce((sum, v) => sum + v);

List<String> renderPixels(List<int> cycles) {
  List<List<String>> chars = [[], [], [], [], [], []];

  for (int row = 0; row < chars.length; row++) {
    for (int i = 0; i < 40; i++) {
      var x = cycles[i + (row * 40)];
      chars[row].add((i + 1 >= x && i + 1 <= x + 2) ? "#" : ".");
    }
  }
  return chars.map((r) => r.join("")).toList();
}

num part1({String fileName = "input.txt"}) => signalStrength(cycles(readFileToLines(fileName)));

List<String> part2({String fileName = "input.txt"}) => renderPixels(cycles(readFileToLines(fileName)));

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
