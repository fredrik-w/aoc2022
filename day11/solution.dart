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

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<Monkey> parseNotes(List<String> notes) {
  List<Monkey> monkeys = [];
  var id = "", items = <int>[], operation = null, test = null, success = -1, failure = -1;
  notes.map((n) => n.trim()).forEach((note) {
    if (note.startsWith("Monkey"))
      id = note.substring(7, 8);
    else if (note.startsWith("Starting items"))
      items = note.split(": ").last.split(",").map(int.parse).toList();
    else if (note.startsWith("Operation")) {
      var equation = note.split("= ").last;
      if (equation.startsWith("old *"))
        operation = (int v) => v * (int.tryParse(equation.split(" ").last) ?? v);
      else
        operation = (int v) => v + int.parse(equation.split(" ").last);
    } else if (note.startsWith("Test"))
      test = int.parse(note.split(" ").last);
    else if (note.startsWith("If true"))
      success = int.parse(note.split(" ").last);
    else if (note.startsWith("If false")) {
      failure = int.parse(note.split(" ").last);
      monkeys.add(Monkey(id, items, operation!, test, success, failure));
    }
  });

  return monkeys;
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
