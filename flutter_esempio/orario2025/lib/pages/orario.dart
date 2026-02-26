import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orario2025/pages/login.dart';
import 'package:orario2025/pages/timetable.dart';

import '../functions/funzioni.dart';
import '../utilities/globals.dart';

class Orario extends StatefulWidget {


  const Orario({super.key});

  @override
  State<Orario> createState() => OrarioState();
}

class OrarioState extends State<Orario> {

  Widget _buildRow(int i) {
    if (i == 0 && Globals.idxCognome != -1) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimeTable(i)),
            );
          },
          child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 4,
              color: Colors.green,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.access_alarm_outlined,
                                size: 40.0,
                                color: Colors.white,
                              ),
                              Text(" ${Globals.docenti.elementAt(i).cognome}",
                                  style: Globals.font0white),
                            ]),
                        const Divider(
                          color: Colors.white,
                          thickness: 2.0,
                        ),
                        Text(
                          "ORE CATTEDRA: ${Globals.docenti.elementAt(i).catt}",
                          style: Globals.font3white,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "CLASSI: ${Globals.docenti.elementAt(i).classi.toString().replaceAll(',', '').replaceAll('[', '').replaceAll(']', '')}",
                          style: Globals.font3white,
                          textAlign: TextAlign.left,
                        ),
                      ],
                  ),
              ),
          ),
      );
    } else {
      return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimeTable(i)),
            );
          },
          child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 4,
              //color: Colors.amberAccent,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.access_alarm_outlined,
                                size: 40.0,
                                color: Colors.green,
                              ),
                              Text(" ${Globals.docenti.elementAt(i).cognome}",
                                  style: Globals.font0Doc),
                            ]),
                        const Divider(
                          color: Colors.green,
                          thickness: 2.0,
                        ),
                        Text(
                          "ORE CATTEDRA: ${Globals.docenti.elementAt(i).catt}",
                          style: Globals.font3Orange,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "CLASSI: ${Globals.docenti.elementAt(i).classi.toString().replaceAll(',', '').replaceAll('[', '').replaceAll(']', '')}",
                          style: Globals.font3Orange,
                          textAlign: TextAlign.left,
                        ),
                      ],
                  ),
              ),
          ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([
      //DeviceOrientation.landscapeLeft,
      //DeviceOrientation.landscapeRight,
      //DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
/*        appBar: AppBar(
          title: Text(Globals.appTitle,
            style: const TextStyle(
              fontSize: 26.0, fontStyle: FontStyle.italic, color: Colors.green,
            ),
          ),
        ),
*/
      appBar: AppBar(
        title: Row(
          children: [
            FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage(),
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
                Globals.appTitle,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.green,
                ),
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
      body: ListView.builder(
          shrinkWrap: true,
              itemCount: Globals.docenti.length,
              itemBuilder: (BuildContext context, int position) {
                return _buildRow(position);
              }),
    );
  }
}
