import 'dart:io';

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

class Node {
  final Node? parent;
  final String name;
  final int? fileSize;
  final List<Node> content = [];

  Node(this.parent, this.name, this.fileSize);

  int size() => this.fileSize ?? this.content.map((n) => n.size()).reduce((sum, size) => sum + size);

  factory Node.directory(Node? parent, String name) => Node(parent, name, null);
  factory Node.file(Node? parent, String name, int size) => Node(parent, name, size);
}

Node parseConsole(List<String> lines) {
  var root = Node.directory(null, "/");
  var current = root;

  lines.forEach((line) {
    if (line.startsWith("\$ cd")) {
      var name = line.split(" ").last;
      if (name == "..") current = current.parent!;
      else if (name != "/") current = current.content.firstWhere((e) => e.name == name && e.fileSize == null);
    } else if (line != "\$ ls") {
      if (line.startsWith("dir")) current.content.add(Node.directory(current, line.split(" ").last));
      else current.content.add(Node.file(current, line.split(" ").last, int.parse(line.split(" ").first)));
    }
  });

  return root;
}

List<Node> findDirectories(Node node) => node.content.where((n) => n.content.length > 0).fold(
    [],
    (nodes, node) => nodes
      ..add(node)
      ..addAll(findDirectories(node)));

num part1({String fileName = "input.txt"}) => findDirectories(parseConsole(readFileToLines(fileName)))
    .map((n) => n.size())
    .where((size) => size <= 100000)
    .reduce((sum, size) => sum + size);

num part2({String fileName = "input.txt"}) => (findDirectories(parseConsole(readFileToLines(fileName)))
        .map((n) => n.size())
        .where((size) => size >= 30000000 - (70000000 - parseConsole(readFileToLines(fileName)).size()))
        .toList()
      ..sort((a, b) => a - b))
    .first;

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
