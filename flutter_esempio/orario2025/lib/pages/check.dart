

import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:orario2025/models/version.dart';
import 'package:orario2025/pages/orario.dart';
import 'package:orario2025/pages/timetable.dart';

import '../functions/funzioni.dart';
import '../functions/readwrite.dart';
import '../utilities/globals.dart';
import 'lostconnection.dart';

class Check extends StatefulWidget {
  late  String name;
  late String surname;

  Check(this.name, this.surname, {super.key});

  @override
  State<Check> createState() => CheckState(name, surname);
}

class CheckState extends State<Check>  with SingleTickerProviderStateMixin{
  late  String name;
  late String surname;

  CheckState(this.name, this.surname);

  int checkResult = 0;
  bool check = true;
  Versione sheetRel = Versione(rel: "", date: "");
  Versione storedRel = Versione(rel: "rel", date: "date");
  var fwJson;
  //String versione = "";
  String lastUpdate = "";

  late Timer timer;

  getLastUpdate() {
    ReadWrite().readFile(Globals.fileUpdate).then((String value) {
      setState(() {
        lastUpdate = value;
        if(lastUpdate.isEmpty ) {
          storedRel.rel = "rel";
          storedRel.date = "date";
        } else {
          var release = convert.jsonDecode(lastUpdate);
          storedRel.rel = release['rel'];
          storedRel.date = release['date'];
        }
      });
    });
  }

  getLastUpdateFromSheet() async {
    try {
      var rawUpdate = await http.get(
          Uri.parse(Globals.urlUpdate),
          headers:{"Content-Type":"application/json"});
      var release = convert.jsonDecode(rawUpdate.body);
      sheetRel.rel = release['versione']['rel'];
      sheetRel.date = release['versione']['date'];

      if(sheetRel.rel != storedRel.rel || sheetRel.date != storedRel.date){
        var rawData = await http.get(Uri.parse(Globals.urlSheet),
            headers:{"Content-Type":"application/json"});

        var profs2 = convert.jsonDecode(rawData.body);
        var versione = profs2['versione'];
        String sData = convert.jsonEncode(profs2);
        ReadWrite().saveFile(sData, Globals.fileJson);
        String sVer = convert.jsonEncode(profs2['versione']);
        ReadWrite().saveFile(sVer, Globals.fileUpdate);

        timer.cancel();

        parseData(surname.toLowerCase().trim(), profs2);
        if (Globals.idxCognome == -1) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => const Orario(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeTable(0),
            ),
          );
        }
      } else {
        ReadWrite().readFile(Globals.fileJson).then((String value){
            timer.cancel();
            var data = convert.jsonDecode(value);
            parseData(surname.toLowerCase().trim(), data);
            if (Globals.idxCognome == -1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const Orario(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimeTable(0),
                ),
              );
            }
          },
        );
      }

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    getLastUpdate();
    getLastUpdateFromSheet();
    //SE NON CARICA L'ORARIO ENTRO 25 SECONDI, REINDIRIZZO ALLA PAGINA LostConnection()
    timer = Timer(
      const Duration(seconds: 60),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const LostConnection(),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Globals.appTitle,
            style: const TextStyle(color: Colors.green),
          ),
          /*actions: <Widget>[
            IconButton(
              iconSize: 50.0,
              tooltip: 'Ricerca',
              icon: const Icon(Icons.search),
              //Don't block the main thread
              onPressed: () {
                //showSearchPage(context, _searchDelegate);
              },
            ),
          ],*/
        ),
        body: Container(
          alignment: Alignment.center,
          child:
          Center(
              child: Lottie.asset("assets/lottie/a.json")
          ),
        ));
  }
}
