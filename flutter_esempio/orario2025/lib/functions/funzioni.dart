import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/consiglio.dart';
import '../models/docente.dart';
import '../models/stanze.dart';
import '../models/version.dart';
import '../utilities/globals.dart';

Future<void> exitDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Vuoi uscire?',
          style: TextStyle(
            color: Colors.green,
            fontSize: 22,
            fontStyle: FontStyle.italic,
          ),
        ),
        content: const Icon(
          Icons.access_alarm_outlined,
          size: 80.0,
          color: Colors.green,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'NO',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'SI',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => SystemNavigator.pop(),
          ),
        ],
      );
    },
  );
}

void parseData(String cognome, var profs2)  {
  var versione = profs2['versione'];
  var docenti = profs2['docenti'];
  var ore = profs2['ore'];
  var stanze = profs2['stanze'][0];
  var consigli = profs2['consigli'];

  Globals.kWords = [];
  Globals.versione = Versione(rel: "", date: "");
  Globals.docenti = [];
  Globals.ore = [];
  Globals.stanze = Stanze(
  aule: [],
  lun: <List<String>>[],
  mar: <List<String>>[],
  mer: <List<String>>[],
  gio: <List<String>>[],
  ven: <List<String>>[],
  sab: <List<String>>[] );
  Globals.consigli = [];

  // Recupero Versione
  Globals.versione.rel = versione['rel'];
  Globals.versione.date = versione['date'];
  // Recupero docenti
  Globals.idxCognome = -1;
  for (int i = 0; i < docenti.length; i++) {
    String n = docenti[i]['cognome'].toString().toLowerCase().trim();
    if (Globals.idxCognome == -1 && n == cognome) {
      Globals.idxCognome = i;
      Globals.docenti.add(Docente.fromJson(docenti[i]));
      break;
    }
  }
  for (int i = 0; i < docenti.length; i++) {
    Globals.kWords.add(docenti[i]['cognome'].toString());
    if(i == Globals.idxCognome) {
      continue;
    }
    Globals.docenti.add(Docente.fromJson(docenti[i]));
  }
  // Recupero ore
  for(int i = 0; i<6; i++){
    Globals.ore.add(ore[i]);
  }
  // Recupero nomi classi
  Globals.stanze.aule = List.from(profs2['stanze'][0]['aule']);
  // Recupero stanze lunedì
  for(int i = 0; i<Globals.ore[0]; i++) {
    Globals.stanze.lun.add(List.from(profs2['stanze'][1]['lun'][i]));
  }
  // Recupero stanze martedì
  for(int i = 0; i<Globals.ore[1]; i++) {
    Globals.stanze.mar.add(List.from(profs2['stanze'][2]['mar'][i]));
  }
  // Recupero stanze mercoledì
  for(int i = 0; i<Globals.ore[2]; i++) {
    Globals.stanze.mer.add(List.from(profs2['stanze'][3]['mer'][i]));
  }
  // Recupero stanze giovedì
  for(int i = 0; i<Globals.ore[3]; i++) {
    Globals.stanze.gio.add(List.from(profs2['stanze'][4]['gio'][i]));
  }
  // Recupero stanze venerdì
  for(int i = 0; i<Globals.ore[4]; i++) {
    Globals.stanze.ven.add(List.from(profs2['stanze'][5]['ven'][i]));
  }
  // Recupero stanze sabato
  for(int i = 0; i<Globals.ore[5]; i++) {
    Globals.stanze.sab.add(List.from(profs2['stanze'][6]['sab'][i]));
  }
  // Recupero i consigli
  var keys = List.from(profs2['consigli'].keys);
  for(int i = 0; i<keys.length; i++){
    var list = List.from(consigli[keys[i]]);
    Consiglio c = Consiglio(mese: keys[i]);

    for(int j = 0; j<list.length; j++){
      DataConsiglio dc = DataConsiglio(
        data: list[j]['data'],
        orario: list[j]['orario'],
        classe: list[j]['classe'],
      );
      c.consigli.add(dc);
    }
    Globals.consigli.add(c);
  }
}
