import 'dart:io';

List<String> readFileToLines(String fileName) => File.fromUri(Uri.file(fileName)).readAsLinesSync();

List<String> assignmentToAreas(String assignment) => assignment.split(',');

List<int> areaMinMax(String range) => range.split('-').map(int.parse).toList();

List<List<int>> areasToMinMax(List<String> areas) => areas.map(areaMinMax).toList();

bool overlapsFully(List<int> a1, List<int> a2) => a2[0] >= a1[0] && a2[1] <= a1[1];
bool overlapsPartial(List<int> a1, List<int> a2) => (a2[0] >= a1[0] && a2[0] <= a1[1]) || (a2[1] <= a1[1]);

bool areasOverlapFully(List<List<int>> areas) => overlapsFully(areas[0], areas[1]) || overlapsFully(areas[1], areas[0]);
bool areasOverlapPartial(List<List<int>> areas) => overlapsPartial(areas[0], areas[1]);

int findOverlapping(List<String> assignments, {required bool partial}) => assignments
    .map(assignmentToAreas)
    .map(areasToMinMax)
    .where(partial ? areasOverlapPartial : areasOverlapFully)
    .length;

num part1({String fileName = "input.txt"}) => findOverlapping(readFileToLines(fileName), partial: false);

num part2({String fileName = "input.txt"}) => findOverlapping(readFileToLines(fileName), partial: true);

void main(List<String> arguments) => print((Platform.environment["part"] ?? "part1") == "part1" ? part1() : part2());
