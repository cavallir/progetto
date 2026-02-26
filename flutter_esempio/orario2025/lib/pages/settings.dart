//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'dart:ui';

import '../utilities/globals.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences sharedPreferences;

  final _font0 = const TextStyle(
    fontSize: 32.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  getSettings() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      Globals.playSoundOpen = sharedPreferences.getBool("sound_open")!;
      Globals.playSoundClose = sharedPreferences.getBool("sound_close")!;
    });
  }

  @override
  void initState() {
    //final player = AudioPlayer();
    //player.play(AssetSource('audio/renato_zero_avvio.wav'));
    getSettings();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazione effetti sonori',
        style: TextStyle(color: Colors.green),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.green,
                value: Globals.playSoundOpen,
                //onChanged: on_Changed,
                onChanged: (bool? value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    Globals.playSoundOpen = value!;
                    prefs.setBool("sound_open", Globals.playSoundOpen);
                    //prefs.commit();
                  });
                },
                title: const Text(
                  'Riproduci all\'avvio',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.green,
                value: Globals.playSoundClose,
                //onChanged: on_Changed,
                onChanged: (bool? value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    Globals.playSoundClose = value!;
                    prefs.setBool("sound_close", Globals.playSoundClose);
                    //prefs.commit();
                  });
                },
                title: const Text(
                  'Riproduci alla chiusura',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(IconData(0xf71e, fontFamily: 'MaterialIcons')),
      ),
    );
  }
}
