import 'dart:io';
import 'dart:convert';
import 'package:dartz/dartz.dart';

// helpers
Future<List<String>> getInputByLine(String inputPath) async {
  return await FileReader(inputPath).readFileByLine();
}

Future<List<List<int>>> getParsedList(String inputPath) async {
  return await FileReader(inputPath).parseFileListInt();
}

/// Helper to either parse input from buffer or file path to a dimension list
List<List<int>> parseInputToDimList(StringBuffer? input, String? filePath) {
  if (input != null) {
    return input
        .toString()
        .split('\n')
        .where((e) => e.isNotEmpty)
        .map((line) => line.split('x').map((e) => int.parse(e)).toList())
        .toList();
  } else if (filePath != null) {
    return getParsedListSync(filePath);
  } else {
    throw Exception("No input provided.");
  }
}

List<List<int>> getParsedListSync(String inputPath) {
  List<List<int>> dimensionsList = [];

  try {
    List<String> lines =
        File(inputPath).readAsLinesSync(); // Synchronous operation

    for (var line in lines) {
      List<int> dimensions = line.split('x').map((e) => int.parse(e)).toList();
      dimensionsList.add(dimensions);
    }

    return dimensionsList;
  } catch (e) {
    throw 'parseFileListInt: $e';
  }
}

Future<List<String>> getInputString(String inputPath) async {
  return await FileReader(inputPath).splitFileStringToList();
}

String getStringSync(String inputPath) {
  try {
    String contents = File(inputPath).readAsStringSync();
    return contents;
  } catch (e) {
    throw 'getSplitStringListSync: $e';
  }
}

Future<String> getFileAsString(String inputPath) async {
  return await FileReader(inputPath).readStringFromFile();
}

/// Streams the lines from a file to a string buffer
Future<StringBuffer> getStringBuffer(String inputPath) async {
  return await FileReader(inputPath).readFileToStringBuffer();
}

Stream<String> streamLinesFromFile(String inputPath) async* {
  final file = File(inputPath);
  await for (var line
      in file.openRead().transform(utf8.decoder).transform(LineSplitter())) {
    yield line;
  }
}

Either<String, String> getInputContent(StringBuffer? inputBuffer) {
  if (inputBuffer == null) {
    return Left("InputBuffer cannot be null.");
  }

  return Right(inputBuffer.toString());
}

class FileReader {
  final String filepath;

  FileReader(this.filepath);

  Future<List<String>> splitFileStringToList() async {
    try {
      String contents = await File(filepath).readAsString();
      List<String> contentList = contents.split('');
      return contentList;
    } catch (e) {
      throw 'readFile: $e';
    }
  }

  Future<String> readStringFromFile() async {
    try {
      String contents = await File(filepath).readAsString();
      return contents;
    } catch (e) {
      throw 'readFile: $e';
    }
  }

  Future<List<String>> readFileByLine() async {
    try {
      List<String> lines = await File(filepath).readAsLines();
      return lines;
    } catch (e) {
      throw 'readFileByLine: $e';
    }
  }

  Future<List<List<int>>> parseFileListInt() async {
    List<List<int>> dimensionsList = [];
    try {
      List<String> lines = await File(filepath).readAsLines();

      for (var line in lines) {
        List<int> dimensions =
            line.split('x').map((e) => int.parse(e)).toList();

        dimensionsList.add(dimensions);
      }

      return dimensionsList;
    } catch (e) {
      throw 'parseFileListInt: $e';
    }
  }

  Future<StringBuffer> readFileToStringBuffer() async {
    StringBuffer buffer = StringBuffer();
    final file = File(filepath);

    // Check if the file exists before proceeding.
    if (await file.exists()) {
      Stream<List<int>> inputStream = file.openRead();

      // Decode the stream of bytes to a stream of lines
      final lines =
          inputStream.transform(Utf8Decoder()).transform(LineSplitter());

      try {
        await for (var line in lines) {
          buffer.writeln(line);
        }
      } catch (e) {
        throw 'An error occurred while reading from the file: $e';
      }
    } else {
      throw 'The file at path $filepath does not exist.';
    }

    return buffer;
  }
}
