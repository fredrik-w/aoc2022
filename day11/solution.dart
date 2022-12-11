import 'dart:io';

class Monkey {
  List<int> items;
  int Function(int value) operation;
  int divisor;
  int success;
  int failure;
  int inspections = 0;

  Monkey(this.items, this.operation, this.divisor, this.success, this.failure);

  int test(int v) => v % this.divisor == 0 ? this.success : this.failure;
}

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<Monkey> parseNotes(List<String> notes) {
  List<Monkey> monkeys = [];
  var items = <int>[], operation = null, test = null, success = -1, failure = -1;
  notes.forEach((note) {
    note = note.trim();
    if (note.startsWith("Starting items")) {
      items = note.split(": ").last.split(",").map(int.parse).toList();
    } else if (note.startsWith("Operation")) {
      var equation = note.split("= ").last;
      if (equation == "old * old") {
        operation = (int v) => v * v;
      } else if (equation.startsWith("old +")) {
        operation = (int v) => v + int.parse(equation.split(" ").last);
      } else {
        operation = (int v) => v * int.parse(equation.split(" ").last);
      }
    } else if (note.startsWith("Test")) {
      test = int.parse(note.split(" ").last);
    } else if (note.startsWith("If true")) {
      success = int.parse(note.split(" ").last);
    } else if (note.startsWith("If false")) {
      failure = int.parse(note.split(" ").last);
      monkeys.add(Monkey(items, operation!, test, success, failure));
    }
  });

  return monkeys;
}

num simulate(List<Monkey> monkeys, int rounds) {
  for (int i = 0; i < rounds; i++) {
    monkeys.forEach((m) {
      m.items.toList().forEach((item) {
        m.inspections++;
        var wl = (m.operation(item) / 3).floor();
        monkeys[m.test(wl)].items.add(wl);
      });
      m.items.clear();
    });
  }
  return (monkeys.map((m) => m.inspections).toList()..sort((a, b) => b - a)).take(2).reduce((sum, val) => sum * val);
}

num part1({String fileName = "input.txt"}) => simulate(parseNotes(readFileToLines(fileName)), 20);

num part2({String fileName = "input.txt"}) => -2;

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
