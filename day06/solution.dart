import 'dart:io';

String readFile(String fileName) => File.fromUri(Uri.file(fileName)).readAsStringSync();

int findMarkerStart(String input, int length) {
  var position = 0;
  while (input.substring(position, position + length).split("").toSet().length != length) position++;
  return position + length;
}

num part1({String fileName = "input.txt"}) => findMarkerStart(readFile(fileName), 4);

num part2({String fileName = "input.txt"}) => findMarkerStart(readFile(fileName), 14);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
