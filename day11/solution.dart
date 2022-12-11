import 'dart:io';

class Monkey {
  String id;
  List<int> items;
  int Function(int value) operation;
  int divisor;
  int success;
  int failure;
  int inspections = 0;

  Monkey(this.id, this.items, this.operation, this.divisor, this.success, this.failure);

  int test(int v) => v % this.divisor == 0 ? this.success : this.failure;
}

String readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsStringSync();

List<Monkey> parseNotes(String notes) {
  return notes
      .split("\n\n")
      .map((blob) => blob.split("\n"))
      .map((parts) => Monkey(
            parts[0].substring(7, 8),
            parts[1].split(": ").last.split(",").map(int.parse).toList(),
            parts[2].split("= ").last.startsWith("old *")
                ? (int v) => v * (int.tryParse(parts[2].split(" ").last) ?? v)
                : (int v) => v + int.parse(parts[2].split(" ").last),
            int.parse(parts[3].split(" ").last),
            int.parse(parts[4].split(" ").last),
            int.parse(parts[5].split(" ").last),
          ))
      .toList();
}

num simulate(List<Monkey> monkeys, int Function(int v) worryAlgorithm, int rounds) {
  for (int i = 1; i <= rounds; i++) {
    monkeys.forEach((m) {
      m.items.forEach((item) {
        var wl = worryAlgorithm(m.operation(item));
        monkeys[m.test(wl)].items.add(wl);
      });
      m.inspections += m.items.length;
      m.items.clear();
    });
  }
  return (monkeys.map((m) => m.inspections).toList()..sort((a, b) => b - a)).take(2).reduce((sum, val) => sum * val);
}

num part1({String fileName = "input.txt"}) =>
    simulate(parseNotes(readFileToLines(fileName)), (int v) => (v / 3).floor(), 20);

num part2({String fileName = "input.txt"}) {
  var monkeys = parseNotes(readFileToLines(fileName));
  var factor = monkeys.map((m) => m.divisor).reduce((sum, v) => sum * v);
  return simulate(monkeys, (v) => v % factor, 10000);
}

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
