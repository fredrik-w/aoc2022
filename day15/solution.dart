import 'dart:io';
import 'dart:math';

class SensorBeacon {
  final Point<int> sensor;
  final Point<int> beacon;
  final int distance;

  SensorBeacon(this.sensor, this.beacon) : this.distance = (sensor.x - beacon.x).abs() + (sensor.y - beacon.y).abs();

  Range? coverageOnLine(int y) {
    int distanceY = (sensor.y - y).abs(), distanceX = distance - distanceY;
    return distanceY > distance ? null : Range(start: sensor.x - distanceX, end: sensor.x + distanceX);
  }
}

class Range {
  final int start;
  final int end;

  const Range({required this.start, required this.end});

  int length() => (this.end - this.start).abs() + 1;

  Range? tryMerge(Range other) => canMerge(other)
      ? Range(
          start: min(min(start, other.start), min(end, other.end)),
          end: max(max(start, other.start), max(end, other.end)))
      : null;

  bool canMerge(Range other) =>
      (other.end >= start && other.end <= end) || // ends in this range
      (other.start >= start && other.start <= end) || // starts in this range
      (other.start >= start && other.end <= end) || // fully inside this range
      (start >= other.start && end <= other.end); // this is fully inside other range
}

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

final RegExp InData = RegExp(r'^Sensor .+ x=(?<sx>\d+), y=(?<sy>\d+): .+ beacon .+ x=(?<bx>-?\d+), y=(?<by>-?\d+)$');

Point<int> toPoint(RegExpMatch m, String x, String y) =>
    Point(int.parse(m.namedGroup(x)!), int.parse(m.namedGroup(y)!));

Iterable<SensorBeacon> parse(List<String> lines) =>
    lines.map(InData.firstMatch).map((m) => SensorBeacon(toPoint(m!, "sx", "sy"), toPoint(m, "bx", "by")));

Iterable<Range> lineCoverage(Iterable<SensorBeacon> report, int y) =>
    report.map((r) => r.coverageOnLine(y)).whereType<Range>();

Iterable<Range> mergeRanges(Iterable<Range> ranges) {
  var sorted = ranges.toList()
    ..sort((a, b) => a.start.compareTo(b.start) == 0 ? a.end.compareTo(b.end) : a.start.compareTo(b.start));
  bool didMerge = true;
  while (didMerge && sorted.length > 1) {
    for (var i = 1; i < sorted.length; i++) {
      if (sorted[i - 1].canMerge(sorted[i])) {
        sorted[i - 1] = sorted[i - 1].tryMerge(sorted[i])!;
        sorted.removeAt(i);
        didMerge = true;
        break;
      }
      didMerge = false;
    }
  }
  return sorted;
}

num coveredArea(Iterable<SensorBeacon> report, int y) =>
    mergeRanges(lineCoverage(report, y)).map((r) => r.length()).reduce((sum, val) => sum + val) -
    report.map((r) => r.beacon).where((b) => b.y == y).toSet().length;

num findDistressBeacon(Iterable<SensorBeacon> report, int limit) {
  for (int y = 0; y <= limit; y++) {
    var coverages = mergeRanges(lineCoverage(report, y));
    if (coverages.length > 1) {
      return (coverages.first.end + 1) * 4000000 + y;
    }
  }
  throw Error();
}

num part1({String fileName = "input.txt", int y = 2000000}) => coveredArea(parse(readFileToLines(fileName)), y);

num part2({String fileName = "input.txt", int limit = 4000000}) =>
    findDistressBeacon(parse(readFileToLines(fileName)), limit);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
