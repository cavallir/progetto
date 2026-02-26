import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File>  getFile(String name) async {
  final path = await _localPath;
  return File('$path/$name');
}
/*
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.json');
}

Future<File> writeData(String data) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(data);
}
*/
Future<File> writeDataFile(String filename, String data) async {
  final file = await getFile(filename);

  return file.writeAsString(data);
}

Future<String> readDataFile(String filename) async {
  try {
    final file = await getFile(filename);
    final contents = file.readAsStringSync();
    return contents;
  } catch (e) {
    return "";
  }
}

