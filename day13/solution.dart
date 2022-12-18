import 'dart:convert';
import 'dart:io';

List<String> readFileToLines(String fileName) =>
    File.fromUri(Uri.file(fileName)).readAsStringSync().trim().split("\n\n");

int comparePackets(List<dynamic> left, List<dynamic> right) {
  for (int i = 0; i < left.length && i < right.length; i++) {
    var lv = left[i], rv = right[i];
    if (lv is int && rv is int) {
      if (lv != rv) return lv - rv;
    } else {
      int inOrder = comparePackets(lv is num ? [lv] : lv, rv is num ? [rv] : rv);
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
    if (comparePackets(key, value) < 0) inOrder.add(idx);
    idx++;
  });
  return inOrder;
}

List<int> sortPackets(Map<List<dynamic>, List<dynamic>> pairs) {
  var dividerPackets = [ [[2]], [[6]] ];
  List<List<dynamic>> packets = [];
  pairs.forEach((key, value) => packets..addAll([key, value]));
  (packets..addAll(dividerPackets)).sort(comparePackets);
  return [
    packets.indexOf(dividerPackets[0]) + 1,
    packets.indexOf(dividerPackets[1]) + 1,
  ];
}

int decoderKey(List<int> indices) => indices.reduce((a, b) => a * b);

num part1({String fileName = "input.txt"}) =>
    pairsInOrder(parseInput(readFileToLines(fileName))).reduce((sum, val) => sum + val);

num part2({String fileName = "input.txt"}) => decoderKey(sortPackets(parseInput(readFileToLines(fileName))));

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
