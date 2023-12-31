import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day2.dart';

// TODO: Convert this to use the data library
void main() {
  group('Day2P1Solver', () {
    test('computes correct paper from given input', () {
      StringBuffer buffer = StringBuffer('2x3x4\n1x1x10'); // Example data
      var solver = Day2P1Solver(buffer);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day2P1Solver: 101');
    });

    test('returns error when input is malformed', () {
      StringBuffer buffer = StringBuffer('2x3x\n1x1x10'); // Malformed data
      var solver = Day2P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    // New test for file fallback
    test('computes correct paper from file input', () {
      var solver = Day2P1Solver(null, 'data/aoc2015_day2_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day2P1Solver: 1606483');
    });
  });

  group('Day2P2Solver', () {
    test('computes correct ribbon from given input', () {
      StringBuffer buffer = StringBuffer('2x3x4\n1x1x10'); // Example data
      var solver = Day2P2Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''), 'Day2P2Solver: 48');
    });

    test('returns error when input is malformed', () {
      StringBuffer buffer = StringBuffer('2x3x\n1x1x10'); // Malformed data
      var solver = Day2P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct ribbon from file input', () {
      var solver = Day2P2Solver(null, 'data/aoc2015_day2_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day2P2Solver: 3842356');
    });
  });
}
