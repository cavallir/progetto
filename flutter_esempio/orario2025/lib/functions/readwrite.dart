import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReadWrite{
  getFilePath(String name) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String filePath = '$path/$name';
    return filePath;
  }

  Future<String>readFile(String name) async{
    try {
      File file = File(await getFilePath(name));
      String fileContent = await file.readAsString();
      return fileContent;
    } catch (e) {
      return "";
    }
  }

  Future<File>saveFile(String text,String name) async {
    final file = File(await getFilePath(name));
    //print(text);
    return file.writeAsString(text);
  }
}