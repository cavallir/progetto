// ignore_for_file: unused_import, must_be_immutable, camel_case_types

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:orario2025/pages/orario.dart';

import '../functions/funzioni.dart';
import '../models/docente.dart';
import '../utilities/globals.dart';
import 'Consigli.dart';

class TimeTable extends StatelessWidget {
  var idx;
  late BuildContext myContext;

  TimeTable(this.idx, {super.key});

  Widget _getBox(int i, int day, int j) {
    return SizedBox(
      width: 33,
      height: 48,
      child: Card(
          margin: const EdgeInsets.all(1.0),
          elevation: 3.8,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Center(
              child: _getDay(i, day, j, true),
            ),
          )),
    );
  }

  String _getAula(int day, int ora, String classe){
    var iAula = Globals.stanze.aule.indexOf(classe);

    var aula =  "";
    switch(day){
      case 0: aula =  (iAula >= 0) ? Globals.stanze.lun[ora].elementAt(iAula) : "";
      break;
      case 1: aula =  (iAula >= 0) ? Globals.stanze.mar[ora].elementAt(iAula) : "";
      break;
      case 2: aula =  (iAula >= 0) ? Globals.stanze.mer[ora].elementAt(iAula) : "";
      break;
      case 3: aula =  (iAula >= 0) ? Globals.stanze.gio[ora].elementAt(iAula) : "";
      break;
      case 4: aula =  (iAula >= 0) ? Globals.stanze.ven[ora].elementAt(iAula) : "";
      break;
      case 5: aula =  (iAula >= 0) ? Globals.stanze.sab[ora].elementAt(iAula) : "";
      break;
      default:
        aula = "";
        break;
    }
    return aula;
  }

  Widget _getDay(int idx, int day, int ora, bool cut) {
    String classe = "";
    switch(day){
      case 0: classe = Globals.docenti[idx].lun.elementAt(ora);
      break;
      case 1: classe = Globals.docenti[idx].mar.elementAt(ora);
      break;
      case 2: classe = Globals.docenti[idx].mer.elementAt(ora);
      break;
      case 3: classe = Globals.docenti[idx].gio.elementAt(ora);
      break;
      case 4: classe = Globals.docenti[idx].ven.elementAt(ora);
      break;
      case 5: classe = Globals.docenti[idx].sab.elementAt(ora);
      break;
    }

    String co = (classe.isNotEmpty) ? getCoPresence(classe, idx, day, ora) : "";
    if(cut == true && co.length > 6) {
      co = co.substring(0, 5);
    }
    if(cut == true) {
      if (co.isNotEmpty) {
        return Column(
          children: [
            Text(
              classe,
              style: Globals.font4,
            ),
            Text(
              _getAula(day, ora, classe),
              style: Globals.font4Aula,
            ),
            Text(
              co,
              style: Globals.font4Comp,
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Text(
              classe,
              style: Globals.font4,
            ),
            Text(
              _getAula(day, ora, classe),
              style: Globals.font4Aula,
            ),
          ],
        );
      }
    } else {
      if (co.isNotEmpty) {
        return Column(
          children: [
            Text(
              classe,
              style: Globals.font4Big,
            ),
            Text(
              _getAula(day, ora, classe),
              style: Globals.font4AulaBig,
            ),
            Text(
              co,
              style: Globals.font4CompBig,
            ),
          ],
        );
      } else {
        return Column(
          children: [
            Text(
              classe,
              style: Globals.font4Big,
            ),
            Text(
              _getAula(day, ora, classe),
              style: Globals.font4AulaBig,
            ),
          ],
        );
      }
    }
  }

  String getCoPresence(String classe, int idx, int day, int ora) {
    for (int k = 0; k < Globals.docenti.length; k++) {

      if(!Globals.docenti[k].classi.contains(classe) || k == idx) {
        continue;
      }

      late List<String> weekDay;

      switch(day){
        case 0: weekDay = Globals.docenti[k].lun;
        break;
        case 1: weekDay = Globals.docenti[k].mar;
        break;
        case 2: weekDay = Globals.docenti[k].mer;
        break;
        case 3: weekDay = Globals.docenti[k].gio;
        break;
        case 4: weekDay = Globals.docenti[k].ven;
        break;
        case 5: weekDay = Globals.docenti[k].sab;
        break;
      }
      String coClasse = weekDay.elementAt(ora);

      if(coClasse == classe){
        return Globals.docenti[k].cognome;
      }
    }
    return "";
  }

  Future<void> _dialogBuilder(BuildContext context, int i, int day, int j) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: const Text(
            '',
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getDay(i, day, j, false),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: FloatingActionButton(
                onPressed: () => Navigator.of(myContext).pop(),
                child:
                const Icon(IconData(0xf71e, fontFamily: 'MaterialIcons')),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getBox2(int i, int day, int ora, double width) {
    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          _dialogBuilder(myContext, i, day, ora);
        },
        child: SizedBox(
          width: width,
          height: 65,
          child: Card(
            margin: const EdgeInsets.fromLTRB(2.5, 6.0, 2.5, 2.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Align(
                alignment: Alignment.center,
                child: _getDay(i, day, ora, true),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBoxIntervallo() {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        width: 15,
        height: 65,
        child: Card(
            margin: const EdgeInsets.fromLTRB(1.5, 5.0, 1.5, 5.0),
            elevation: 5,
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "I",
                  style: Globals.font4white,
                ),
              ),
            )),
      ),
    );
  }

  Widget buildDayTime(int i, int day, int ore) {
    if (ore == 4) {
      return SizedBox(
        height: 65.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            getBox2(i, day, 0, 60.0),
            getBox2(i, day, 1, 60.0),
            getBoxIntervallo(),
            getBox2(i, day, 2, 60.0),
            getBox2(i, day, 3, 60.0),
          ],
        ),
      );
    } else if (ore == 5) {
      return SizedBox(
        height: 65.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            getBox2(i, day, 0, 60.0),
            getBox2(i, day, 1, 60.0),
            getBox2(i, day, 2, 60.0),
            getBoxIntervallo(),
            getBox2(i, day, 3, 60.0),
            getBox2(i, day, 4, 60.0),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 65.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            getBox2(i, day, 0, 50.0),
            getBox2(i, day, 1, 50.0),
            getBox2(i, day, 2, 50.0),
            getBoxIntervallo(),
            getBox2(i, day, 3, 50.0),
            getBox2(i, day, 4, 50.0),
            getBox2(i, day, 5, 50.0),
          ],
        ),
      );
    }
  }

  Widget _buildDay6h(int i, int day, String giorno) {
    return GestureDetector(
      onTap: () {},
      child: Row(children: [
        buildDayTime(i, day, 6),
      ]),
    );
  }

  Widget _buildDay5h(int i, int day, String giorno) {
    return GestureDetector(
      onTap: () {},
      child: Row(children: [
        buildDayTime(i, day, 5),
      ]),
    );
  }

  Widget getDayTime(int iDoc, int iDay) {
    return GestureDetector(
      onTap: () {},
      child: Row(children: [
        buildDayTime(iDoc, iDay, Globals.ore[iDay]),
      ]),
    );
  }

  Widget _buildDay(int idx, int iDay) {
    String giorno = Globals.days.elementAt(iDay);

    switch (iDay) {
      case 0:
        {
          if (Globals.ore[iDay] == 5) {
            return _buildDay5h(idx, iDay, giorno);
          } else {
            return _buildDay6h(idx, iDay, giorno);
          }
        }
        break;

      case 1:
        {
          if (Globals.ore[iDay] == 5) {
            return _buildDay5h(idx, iDay, giorno);
          } else {
            return _buildDay6h(idx, iDay, giorno);
          }
        }
        break;

      case 2:
        {
          if (Globals.ore[iDay] == 5) {
            return _buildDay5h(idx, iDay, giorno);
          } else {
            return _buildDay6h(idx, iDay, giorno);
          }
        }
        break;

      case 3:
        {
          if (Globals.ore[iDay] == 5) {
            return _buildDay5h(idx, iDay, giorno);
          } else {
            return _buildDay6h(idx, iDay, giorno);
          }
        }
        break;

      case 4:
        {
          if (Globals.ore[iDay] == 5) {
            return _buildDay5h(idx, iDay, giorno);
          } else {
            return _buildDay6h(idx, iDay, giorno);
          }
        }

      case 5:
        {
          if (Globals.ore[iDay] == 5) {
            return _buildDay5h(idx, iDay, giorno);
          } else {
            return _buildDay6h(idx, iDay, giorno);
          }
        }
        break;
      default:
        {
          if (Globals.ore[iDay] == 5) {
            return _buildDay5h(idx, iDay, giorno);
          } else {
            return _buildDay6h(idx, iDay, giorno);
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    myContext = context;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Orario(),
                  ),
                );
              },
              tooltip: 'CDC',
              elevation: 0,
              //child: const Icon(IconData(0xf71e, fontFamily: 'MaterialIcons')),
              icon: const Icon(
                IconData(
                  0xe092,
                  fontFamily: 'MaterialIcons',
                  matchTextDirection: true,
                ),
                color: Colors.green,
              ),
              label: Text(
                Globals.docenti.elementAt(idx).cognome,
                style: const TextStyle(
                    color: Colors.green,
                    backgroundColor: Colors.white,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              onPressed: () {
                if (Globals.playSoundClose) {
                  AudioPlayer()
                      .play(AssetSource('audio/renato_zero_chiusura.wav'));
                }
                exitDialog(context);
              },
              tooltip: 'Esci',
              child: const Icon(
                IconData(0xf71e, fontFamily: 'MaterialIcons'),
                color: Colors.green,
                size: 40,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 35,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                      elevation: 10.0,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "LUNEDI'",
                              style: Globals.font4Days,
                            )),
                      )),
                ),
                _buildDay(idx, 0),
                SizedBox(
                  width: 200,
                  height: 35,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                      elevation: 10.0,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "MARTEDI'",
                              style: Globals.font4Days,
                            )),
                      )),
                ),
                _buildDay(idx, 1),
                SizedBox(
                  width: 200,
                  height: 35,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                      elevation: 10.0,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "MERCOLEDI'",
                              style: Globals.font4Days,
                            )),
                      )),
                ),
                _buildDay(idx, 2),
                SizedBox(
                  width: 200,
                  height: 35,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                      elevation: 10.0,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "GIOVEDI'",
                              style: Globals.font4Days,
                            )),
                      )),
                ),
                _buildDay(idx, 3),
                SizedBox(
                  width: 200,
                  height: 35,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                      elevation: 10.0,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "VENERDI'",
                              style: Globals.font4Days,
                            )),
                      )),
                ),
                _buildDay(idx, 4),
                SizedBox(
                  width: 200,
                  height: 35,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                      elevation: 10.0,
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "SABATO",
                              style: Globals.font4Days,
                            )),
                      )),
                ),
                _buildDay(idx, 5),
                const SizedBox(height: 500,),
                //const SizedBox(height: 30,),
              ],
            ),
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConsigliPage(classi: List.from(Globals.docenti[idx].classi)),
            ),
          );
        },
        tooltip: 'CDC',
        elevation: 10,
        //child: const Icon(IconData(0xf71e, fontFamily: 'MaterialIcons')),
        label: const Text('CONSIGLI DI CLASSE'),
        icon: const Icon(IconData(0xf71e, fontFamily: 'MaterialIcons')),
      ),
    );
  }
}
