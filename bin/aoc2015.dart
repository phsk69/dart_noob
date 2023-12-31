import 'dart:io';
import 'package:logging/logging.dart';
import 'package:dart_noob/util/util.dart';
import 'package:dart_noob/factories/solver_factory.dart';

//TODO: Implement support for default mode per day, ie. use the data lib for the defined day if no input file is defined
Future<void> main(List<String> args) async {
  final cliArgsManager = CliArgsManager(args);
  // This is done to make the CliArgsManager testable
  cliArgsManager.handleHelpFlag();

  final inputFile = cliArgsManager.inputFile;
  final outputFile = cliArgsManager.outputFile;
  final logFile = cliArgsManager.logFile;
  final logLevel = cliArgsManager.logLevel;
  final mode = cliArgsManager.mode;

  final sinkManager = SinkManager();
  final outputManager = OutputManager(sinkManager, outputFile);

  var loggerManager = LoggerManager(
    name: 'AOC2015',
    logFile: logFile,
    logLevel: logLevel,
    sinkManager: sinkManager,
    outputManager: outputManager,
  );

  final Logger? logger = loggerManager.log;

  SignalHandler(
      sinkManager: sinkManager, logger: logger, outputManager: outputManager);

  StringBuffer? inputBuffer;

  if (inputFile != null) {
    String infoMsg = 'Input: $inputFile';
    outputManager.writeOutput(infoMsg);
    logger?.info(infoMsg);

    try {
      inputBuffer = await getStringBuffer(inputFile);
    } catch (e) {
      String errorMsg = 'Failed to get input buffer: ${e.toString()}';
      outputManager.writeError(errorMsg);
      logger?.severe(errorMsg);
      await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);
      exit(1);
    }
  }

  if (outputFile != null) {
    String infoMsg = 'Output: $outputFile';
    outputManager.writeOutput(infoMsg);
    logger?.info(infoMsg);
  }

  if (mode != null && inputFile != null && inputBuffer != null) {
    outputManager.writeOutput('Mode: $mode');
    final solversResult = SolverFactory.create(mode, inputBuffer, null, logger);

    solversResult.fold((error) {
      outputManager.writeError(error);
      logger?.severe(error);
    }, (solvers) {
      for (var solver in solvers) {
        final result = solver.solve();
        result.fold((l) {
          // Handle the left side (error)
          outputManager.writeError(l);
          logger?.severe(l);
        }, (r) {
          // Handle the right side (success)
          outputManager.writeOutput(r);
          logger?.info(r);
        });
      }
    });
  } else if (mode == null && inputFile == null && inputBuffer == null) {
    outputManager.writeOutput('Mode: default');
    final solversResult = SolverFactory.create('default', null, null, logger);

    solversResult.fold((error) {
      outputManager.writeError(error);
      logger?.severe(error);
    }, (solvers) {
      for (var solver in solvers) {
        final result = solver.solve();
        result.fold((l) {
          // Handle the left side (error)
          outputManager.writeError(l);
          logger?.severe(l);
        }, (r) {
          // Handle the right side (success)
          outputManager.writeOutput(r);
          logger?.info(r);
        });
      }
    });
  } else if (mode == null) {
    const String invalidModeMsg = 'Mode not supported';
    outputManager.writeError(invalidModeMsg);
    logger?.severe(invalidModeMsg);
  } else if (inputFile == null) {
    const String invalidInputMsg = 'Input file path not supported';
    outputManager.writeError(invalidInputMsg);
    logger?.severe(invalidInputMsg);
  } else if (inputBuffer == null) {
    const String invalidInputBufferMsg = 'Input buffer is null';
    outputManager.writeError(invalidInputBufferMsg);
    logger?.severe(invalidInputBufferMsg);
  }

  await handleCloseResources(sinkManager.logSink, sinkManager.outputSink);
  exit(0);
}
