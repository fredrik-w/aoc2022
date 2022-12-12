import 'dart:io';

const LOST = 0, DRAW = 3, WON = 6, ROCK = 1, PAPER = 2, SCISSORS = 3;

enum Guide {
  AX("A X", ROCK + DRAW, SCISSORS + LOST),
  AY("A Y", PAPER + WON, ROCK + DRAW),
  AZ("A Z", SCISSORS + LOST, PAPER + WON),
  BX("B X", ROCK + LOST, ROCK + LOST),
  BY("B Y", PAPER + DRAW, PAPER + DRAW),
  BZ("B Z", SCISSORS + WON, SCISSORS + WON),
  CX("C X", ROCK + WON, PAPER + LOST),
  CY("C Y", PAPER + LOST, SCISSORS + DRAW),
  CZ("C Z", SCISSORS + DRAW, ROCK + WON);

  final String value;
  final int part1Points;
  final int part2Points;
  const Guide(this.value, this.part1Points, this.part2Points);

  static Guide fromString(String value) => values.firstWhere((v) => v.value == value);
}

int calculateRoundPoints(String fileName, int Function(Guide g) pointExtractor) {
  return File.fromUri(Uri.file(fileName))
      .readAsLinesSync()
      .map((line) => pointExtractor(Guide.fromString(line)))
      .toList()
      .reduce((sum, val) => sum += val);
}

int part1({String fileName = "input.txt"}) => calculateRoundPoints(fileName, (g) => g.part1Points);

int part2({String fileName = "input.txt"}) => calculateRoundPoints(fileName, (g) => g.part2Points);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
