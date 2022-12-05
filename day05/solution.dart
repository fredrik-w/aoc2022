import 'dart:io';

var crateRegExp = RegExp(r'\[([A-Z])\]\s?|(\s{3}\s)');
var instructionRegExp = RegExp(r'^move (?<num>\d+) from (?<from>\d) to (?<to>\d)$');

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

class Instruction {
  final int from;
  final int to;
  final int amount;
  Instruction(String from, String to, String amount)
      : this.from = int.parse(from) - 1,
        this.to = int.parse(to) - 1,
        this.amount = int.parse(amount);
}

class Puzzle {
  final List<List<String?>> crates;
  final List<Instruction> instructions;
  const Puzzle(this.crates, this.instructions);
}

Puzzle parseInput(List<String> lines) {
  List<List<String?>> columns = [];
  List<Instruction> instructions = [];

  bool cratesDone = false;
  lines.forEach((line) {
    if (line.isEmpty) {
      cratesDone = true;
    } else {
      var matches = cratesDone ? instructionRegExp.allMatches(line) : crateRegExp.allMatches(line);
      if (matches.isNotEmpty) {
        if (!cratesDone) {
          matches.toList(growable: false).asMap().forEach((index, match) {
            if (columns.length <= index) {
              columns.add([]);
            }
            String? crate = match[0]!.trim().isEmpty ? null : match[1];
            columns[index].add(crate);
          });
        } else {
          var match = matches.first;
          instructions.add(Instruction(match.namedGroup("from")!, match.namedGroup("to")!, match.namedGroup("num")!));
        }
      }
    }
  });

  int numberOfColumns = columns.map((col) => col.length).reduce((max, num) => num > max ? num : max);
  for (final col in columns) {
    while (col.length < numberOfColumns) col.insert(0, null);
  }
  columns.forEach((col) => col.length = numberOfColumns);
  return Puzzle(columns, instructions);
}

String crateMover(Puzzle puzzle, {bool keepPosition = false}) {
  var crates = puzzle.crates;
  puzzle.instructions.forEach((instruction) {
    int fromIndex = crates[instruction.from].indexWhere((c) => c != null);
    var cratesToMove = crates[instruction.from].sublist(fromIndex, fromIndex + instruction.amount);
    if (keepPosition) cratesToMove = cratesToMove.reversed.toList();
    cratesToMove.forEach((crate) {
      var position = crates[instruction.to].lastIndexWhere((c) => c == null);
      if (position == -1) {
        crates[instruction.to].insert(0, crate);
      } else {
        crates[instruction.to][position] = crate;
      }
    });
    crates[instruction.from].fillRange(fromIndex, fromIndex + instruction.amount, null);
  });

  return crates.map((col) => col.firstWhere((c) => c != null)).join("");
}

String part1({String fileName = "input.txt"}) => crateMover(parseInput(readFileToLines(fileName)));

String part2({String fileName = "input.txt"}) => crateMover(parseInput(readFileToLines(fileName)), keepPosition: true);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
