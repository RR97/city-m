import 'dart:io';
import 'package:path_provider/path_provider.dart';

/*
 * Get the path to the directory where the data will be stored
 */

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/*
 * Create reference to the file that will contain the data
 */

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/pretzelHunt.txt');
}

/*
 * Write/Save data to local storage(file)
 */

Future<File> writeContent(data) async {
  final file = await _localFile;
  return file.writeAsString(data);
}

/*
 * Take data from the storage/file
 */

Future<String> readContent() async {
  try {
    final file = await _localFile;
    // Read the file
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return '{}';
  }
}