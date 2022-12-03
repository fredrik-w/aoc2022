import 'dart:core';
import 'dart:io';

Set<String> toSet(String s) => s.split("").toSet();

List<String> intersection(String c1, String c2) => toSet(c1).intersection(toSet(c2)).toList();

int codeToPrio(int code) => code >= 97 ? code - 96 : code - 38;

List<int> itemToPrio(List<String> common) => common.map((c) => codeToPrio(c.codeUnitAt(0))).toList();

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<String> getCompartments(String rucksack) =>
    [rucksack.substring(0, rucksack.length ~/ 2), rucksack.substring(rucksack.length ~/ 2)];

List<List<String>> findMisplaced(List<String> rucksacks) {
  return rucksacks.map((rucksack) {
    var compartments = getCompartments(rucksack);
    return intersection(compartments[0], compartments[1]);
  }).toList();
}

List<List<String>> findGroupMisplaced(List<String> rucksacks) {
  List<List<String>> groups = [];
  for (int i = 0; i < rucksacks.length; i += 3) {
    groups.add(rucksacks.sublist(i, i + 3));
  }

  return groups.map((g) => toSet(g[0]).intersection(intersection(g[1], g[2]).toSet()).toList()).toList();
}

List<int> calculatePrioList(List<List<String>> items) => items.map(itemToPrio).expand((e) => e).toList();

int part1({String fileName = "input.txt"}) =>
    calculatePrioList(findMisplaced(readFileToLines(fileName))).reduce((sum, val) => sum += val);

int part2({String fileName = "input.txt"}) =>
    calculatePrioList(findGroupMisplaced(readFileToLines(fileName))).reduce((sum, val) => sum += val);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
