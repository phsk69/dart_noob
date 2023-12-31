import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day4.dart'; // Adjust this import path

// TODO: Convert this to use the data library
void main() {
  group('Day4P1Solver', () {
    test('computes correct MD5 hash index from given input', () {
      // newline added here because the entry makes a buffer with newline
      StringBuffer buffer = StringBuffer('0\n');
      var solver = Day4P1Solver(buffer);

      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day4P1Solver: 79446');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer(''); // Empty data
      var solver = Day4P1Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes correct MD5 hash index from file input', () {
      var solver = Day4P1Solver(null, 'data/aoc2015_day4_input.txt');

      var result = solver.solve();
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day4P1Solver: 254575');
    });
  });

  group('Day4P2Solver', () {
    test('computes true MD5 hash index with more zeroes from given input', () {
      // newline added here because the entry makes a buffer with newline
      StringBuffer buffer = StringBuffer('00\n');
      var solver = Day4P2Solver(buffer);

      var result = solver.solve();

      expect(result.getOrElse(() => ''), 'Day4P2Solver: 451787');
    });

    test('returns error when input is empty', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day4P2Solver(buffer);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes true MD5 hash index with additional zeroes from file input',
        () {
      var solver = Day4P2Solver(null, 'data/aoc2015_day4_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day4P2Solver: 1038736');
    });
  });
}
