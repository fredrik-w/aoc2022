import 'dart:io';

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<int> cycles(List<String> instructions) {
  List<int> register = <int>[1];

  var index = 0;
  instructions.forEach((inst) {
    var val = register.last;
    register.add(val);
    if (inst.startsWith("addx")) register.add(val + int.parse(inst.split(" ").last));
  });

  return register;
}

int signalStrength(List<int> cycles) {
  return 20 * cycles[19] +
      60 * cycles[59] +
      100 * cycles[99] +
      140 * cycles[139] +
      180 * cycles[179] +
      220 * cycles[219];
}

List<String> renderPixels(List<int> cycles) {
  List<List<String>> chars = [[], [], [], [], [], []];

  for (int row = 0; row < chars.length; row++) {
    for (int i = 0; i < 40; i++) {
      var x = cycles[i + (row * 40)];
      chars[row].add((i + 1 >= x && i + 1 <= x + 2) ? "#" : ".");
    }
  }
  var rows = chars.map((r) => r.join("")).toList();

  print(rows.join("\n"));
  return rows;
}

num part1({String fileName = "input.txt"}) => signalStrength(cycles(readFileToLines(fileName)));

List<String> part2({String fileName = "input.txt"}) => renderPixels(cycles(readFileToLines(fileName)));

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
