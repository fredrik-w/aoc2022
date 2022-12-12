import 'dart:io';

Set<String> toSet(String s) => s.split("").toSet();

List<String> intersection(List<String> c) => toSet(c[0]).intersection(toSet(c[1])).toList();

int codeToPrio(int code) => code >= 97 ? code - 96 : code - 38;

List<int> itemToPrio(List<String> common) => common.map((c) => codeToPrio(c.codeUnitAt(0))).toList();

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<String> getCompartments(String sack) => [sack.substring(0, sack.length ~/ 2), sack.substring(sack.length ~/ 2)];

Iterable<List<String>> findMisplaced(List<String> sack) => sack.map((s) => intersection(getCompartments(s)));

Iterable<List<String>> findGroupMisplaced(List<String> rucksacks) {
  List<List<String>> groups = [];
  for (int i = 0; i < rucksacks.length; i += 3) {
    groups.add(rucksacks.sublist(i, i + 3));
  }

  return groups.map((g) => toSet(g[0]).intersection(intersection(g.sublist(1)).toSet()).toList());
}

int calculatePrioSum(Iterable<List<String>> items) =>
    items.map(itemToPrio).expand((e) => e).reduce((sum, val) => sum + val);

int part1({String fileName = "input.txt"}) => calculatePrioSum(findMisplaced(readFileToLines(fileName)));

int part2({String fileName = "input.txt"}) => calculatePrioSum(findGroupMisplaced(readFileToLines(fileName)));

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
