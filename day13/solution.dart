import 'dart:convert';
import 'dart:io';

List<String> readFileToLines(String fileName) =>
    File.fromUri(Uri.file(fileName)).readAsStringSync().trim().split("\n\n");

num inputIsInOrder(List<dynamic> left, List<dynamic> right) {
  for (int i = 0; i < left.length && i < right.length; i++) {
    var lv = left[i], rv = right[i];
    if (lv is num && rv is num) {
      if (lv != rv) return lv - rv;
    } else {
      num inOrder = inputIsInOrder(lv is num ? [lv] : lv, rv is num ? [rv] : rv);
      if (inOrder != 0) return inOrder;
    }
  }
  return left.length - right.length;
}

Map<List<dynamic>, List<dynamic>> parseInput(List<String> data) {
  Map<List<dynamic>, List<dynamic>> pairs = {};
  data.forEach((tuple) {
    var parts = tuple.split("\n").map(jsonDecode).toList();
    pairs.putIfAbsent(parts[0], () => parts[1]);
  });
  return pairs;
}

List<int> pairsInOrder(Map<List<dynamic>, List<dynamic>> pairs) {
  List<int> inOrder = [];
  int idx = 1;
  pairs.forEach((key, value) {
    if (inputIsInOrder(key, value) < 0) inOrder.add(idx);
    idx++;
  });
  return inOrder;
}

num part1({String fileName = "input.txt"}) =>
    pairsInOrder(parseInput(readFileToLines(fileName))).reduce((sum, val) => sum + val);

num part2({String fileName = "input.txt"}) => -2;

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
