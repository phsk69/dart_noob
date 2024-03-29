import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dart_noob/factories/solver_factory.dart';

class Day1P1Solver extends AoCSolver {
  final String? filePath;

  Day1P1Solver(super.input, [this.filePath]);

  @override
  Either<String, String> solve() {
    try {
      final content = input?.toString() ??
          (filePath != null ? File(filePath!).readAsStringSync() : "");

      var i = 0;
      for (var element in content.split('')) {
        switch (element) {
          case '(':
            i++;
            break;
          case ')':
            i--;
            break;
        }
      }
      return Right('Day1P1Solver: $i');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day1P2Solver extends AoCSolver {
  final String? filePath;

  Day1P2Solver(super.input, [this.filePath]);

  @override
  Either<String, String> solve() {
    try {
      final content = input?.toString() ??
          (filePath != null ? File(filePath!).readAsStringSync() : "");

      var floor = 0;
      const int basement = -1;
      var firstBasementPos = 0;

      for (var idx = 0; idx < content.length; idx++) {
        var element = content[idx];
        switch (element) {
          case '(':
            floor++;
            break;
          case ')':
            floor--;
            if (floor == basement) {
              firstBasementPos = idx + 1;
              return Right('Day1P2Solver: $firstBasementPos');
            }
            break;
        }
      }
      return Left("Never reached the basement");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
