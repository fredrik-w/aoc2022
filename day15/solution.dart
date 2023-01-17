import 'dart:io';
import 'dart:math';

class SensorBeacon {
  final MPoint<int> sensor;
  final MPoint<int> beacon;

  const SensorBeacon(this.sensor, this.beacon);

  List<int> coverageOnLine(int y) {
    int distanceX, distanceY, distance = this.sensor.manhattanDistance(beacon);
    if ((distanceY = (sensor.y - y).abs()) > distance) {
      return [];
    }
    distanceX = distance - distanceY;
    return List.generate(distanceX * 2 + 1, (idx) => idx + (sensor.x - distanceX));
  }
}

class MPoint<T extends num> extends Point<T> {
  const MPoint(T x, T y) : super(x, y);

  T manhattanDistance(MPoint<T> other) => ((this.x - other.x).abs() + (this.y - other.y).abs()) as T;
}

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

final RegExp InData = RegExp(r'^Sensor .+ x=(?<sx>\d+), y=(?<sy>\d+): .+ beacon .+ x=(?<bx>-?\d+), y=(?<by>-?\d+)$');

MPoint<int> toPoint(RegExpMatch m, String x, String y) =>
    MPoint(int.parse(m.namedGroup(x)!), int.parse(m.namedGroup(y)!));

Iterable<SensorBeacon> parse(List<String> lines) =>
    lines.map(InData.firstMatch).map((m) => SensorBeacon(toPoint(m!, "sx", "sy"), toPoint(m, "bx", "by")));

num coveredArea(Iterable<SensorBeacon> report, int y) {
  var coverage = report.map((r) => r.coverageOnLine(y)).expand((list) => list).toSet().length;
  var beacons = report.map((r) => r.beacon).where((b) => b.y == y).toSet().length;
  return coverage - beacons;
}

num part1({String fileName = "input.txt", int y = 2000000}) => coveredArea(parse(readFileToLines(fileName)), y);

num part2({String fileName = "input.txt"}) => -2;

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
