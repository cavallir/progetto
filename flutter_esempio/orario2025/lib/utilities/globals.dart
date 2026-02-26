import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions/SearchAppBarDelegate.dart';
import '../models/consiglio.dart';
import '../models/docente.dart';
import '../models/stanze.dart';
import '../models/user.dart';
import '../models/version.dart';



class Globals {

  static late SharedPreferences prefs;
  static bool checkValue = false;
  static bool playSoundFlag = false;
  static User user = User(name: "name", surname: "surname");

  static late Versione versione;
  static late List<Docente> docenti;
  static late List<int> ore;
  static late Stanze stanze;
  static late List<Consiglio> consigli;

  static late SearchAppBarDelegate searchDelegate;
  static late List<String> kWords;

  late double screen_width;
  late double screen_height;
  static var screen_orientation;

  static bool playSoundOpen = false;
  static bool playSoundClose = false;

  // static List<Consiglio> consigli = <Consiglio>[];
  // static List<Distaccamento> distaccamenti = <Distaccamento>[];

  static String appTitle = "Orario ITIS G. Galilei";
  late String formattedDate;

  static var titleWidget = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.lightBlue,
  );

  static Set<String> days = {
    "lunedi",
    "martedi",
    "mercoledi",
    "giovedi",
    "venerdi",
    "sabato"
  };


  static String url =
  "https://script.google.com/macros/s/AKfycbxtOoR8YOcTXuBJP79oQhXCzUUVfixciVBiiBmoRkrrLxEQXHC9pp5spr4qJ3zPD6K4ZQ/exec";
  static String urlSheet = url;
  static String urlUpdate = '$url?cmd=rel';
  static String fileUpdate = 'versione.json';
  static String fileJson = 'data.json';

  static int idxCognome = - 1;

  static var font0 = const TextStyle(
    fontSize: 36.0,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  static var font0Doc = const TextStyle(
    fontSize: 28.0,
    fontStyle: FontStyle.italic,
    color: Colors.green,
  );

  static var fontError = const TextStyle(
    fontSize: 24.0,
    fontStyle: FontStyle.italic,
    color: Colors.red,
  );

  static var font0white = const TextStyle(
      fontSize: 28.0, fontStyle: FontStyle.italic, color: Colors.white);

  static var font0Orange = const TextStyle(
      fontSize: 28.0, fontStyle: FontStyle.italic, color: Colors.green);

  static var font1 = const TextStyle(fontSize: 28.0, color: Colors.green);
  static var font1white = const TextStyle(fontSize: 28.0, color: Colors.white);
  static var font2 = const TextStyle(
    fontSize: 14.0,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.green,
  );
  static var font2white = const TextStyle(
    fontSize: 14.0,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
  );
  static var font3Orange = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
  );

  static var font3white = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
  );

  static var font4Days = const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.white,
  );

  static var font4 = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    //fontStyle: FontStyle.italic,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.green,
  );

  static var font4Big = const TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
    //fontStyle: FontStyle.italic,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.green,
  );

  static var font4violet = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.purple,
  );

  static var font4green = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.green,
  );

  static var font4red = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.redAccent,
  );

  static var font4Aula = const TextStyle(
    fontSize: 8.5,
    fontWeight: FontWeight.bold,
    //fontStyle: FontStyle.italic,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.blue,
  );

  static var font4AulaBig = const TextStyle(
    fontSize:36,
    fontWeight: FontWeight.bold,
    //fontStyle: FontStyle.italic,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.blue,
  );

  static var font4Comp = const TextStyle(
    fontSize: 8.5,
    fontWeight: FontWeight.bold,
    //fontStyle: FontStyle.italic,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.red,
  );

  static var font4CompBig = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.red,
  );

  static var font4white = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFeatures: [FontFeature.tabularFigures()],
    fontFamily: 'SourceCodePro',
    color: Colors.white,
  );

  static var fontLogin = const TextStyle(
    fontSize: 32.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
