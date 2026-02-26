
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/constants.dart';
import '../utilities/globals.dart';
import 'check.dart';
import 'settings.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      try {
        getCredential();
      } catch(e){
        if (kDebugMode) {
          print(e.toString());
        }
      }
    });
  }

  @override
  void dispose() {
    final player = AudioPlayer();
    player.play(AssetSource('audio/renato_zero_chiusura.wav'));
    name.dispose();
    surname.dispose();
    super.dispose();
  }

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

  void playSound() {
    if (Globals.playSoundClose) {
      AudioPlayer().play(AssetSource('audio/renato_zero_chiusura.wav'));
    }
    exitDialog(context);
  }

  onSelected(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Settings()));
        break;
      case 1:
        playSound();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: Text(
            "${Globals.appTitle}\n${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              textTheme: const TextTheme().apply(bodyColor: Colors.white),
            ),
            child: PopupMenuButton<int>(
              color: Colors.green,
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Impostazioni'),
                ),
                const PopupMenuDivider(
                  height: 2,
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Icon(IconData(0xf71e, fontFamily: 'MaterialIcons')),
                      SizedBox(width: 8),
                      Text('Esci'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _body(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Globals.playSoundClose) {
            AudioPlayer().play(AssetSource('audio/renato_zero_chiusura.wav'));
          }
          exitDialog(context);
        },
        tooltip: 'Esci',
        child: const Icon(IconData(0xf71e, fontFamily: 'MaterialIcons')),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () => {
                if (Globals.playSoundOpen)
                  AudioPlayer().play(AssetSource('audio/renato_zero_avvio.wav'))
              },
              child: const Icon(
                Icons.access_alarm_outlined,
                size: 180.0,
                color: Colors.green,
              ),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            //keyboardType: TextInputType.emailAddress,
            onChanged: (value) => Globals.user.name = value,
            controller: name,
            enableSuggestions: true,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 25,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Inserire il nome";
              }
              return null;
            },
            textAlign: TextAlign.left,
            decoration: kTextFieldDecoration.copyWith(
              //hintText: 'Email',
                labelText: "Nome",
                labelStyle: const TextStyle(color: Colors.green),
                prefixIcon: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.green,
                ),
                hintText: 'Inserisci il nome',
                hintStyle: TextStyle(
                  color: Colors.redAccent.withOpacity(0.3),
                  fontSize: 20,
                )),
          ),
          const SizedBox(height: 30),
          TextFormField(
            textInputAction: TextInputAction.done,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 25,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Inserire il cognome";
              }
              return null;
            },
            onChanged: (value) => Globals.user.surname = value,
            textAlign: TextAlign.left,
            decoration: kTextFieldDecoration.copyWith(
                labelText: 'Cognome',
                labelStyle: const TextStyle(color: Colors.green),
                prefixIcon: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.green,
                ),
                hintText: 'Inserisci il cognome',
                hintStyle: TextStyle(
                  color: Colors.redAccent.withOpacity(0.3),
                  fontSize: 20,
                )),
            controller: surname,
            enableSuggestions: true,
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: Globals.checkValue,
            onChanged: (bool? value) /*async*/ {
                setState(() {
                  Globals.checkValue = value!;
                  Globals.prefs.setBool("check", Globals.checkValue);
                  Globals.prefs.setString("name", name.text);
                  Globals.prefs.setString("surname", surname.text);
                  // ignore: deprecated_member_use
                  Globals.prefs.commit();
                });
            },
            title: const Text(
              'Ricordami',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.green,
            ),
            child: ListTile(
              title: Text(
                'Orario',
                textAlign: TextAlign.center,
                style: Globals.font0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Check(name.text, surname.text)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void getCredential() async {
    try {
      Globals.prefs= await SharedPreferences.getInstance();
      //setState(() {
      if (Globals.prefs.containsKey("check")) {
        Globals.checkValue = Globals.prefs.getBool("check")!;
      } else {
        Globals.checkValue = false;
      }

      Globals.checkValue = Globals.prefs.getBool("check")!;
      if (Globals.checkValue) {
        if (Globals.prefs.containsKey("name")) {
          Globals.user.name = Globals.prefs.getString("name")!;
        } else {
          Globals.user.name = "";
        }

        if (Globals.prefs.containsKey("surname")) {
          Globals.user.surname = Globals.prefs.getString("surname")!;
        } else {
          Globals.user.name = "";
        }
      } else {
        Globals.user.name = "";
        Globals.user.name = "";
      }

      if (Globals.prefs.containsKey("sound_open")) {
        Globals.playSoundOpen = Globals.prefs.getBool("sound_open")!;
      } else {
        Globals.playSoundOpen = false;
      }

      if (Globals.prefs.containsKey("sound_close")) {
        Globals.playSoundClose = Globals.prefs.getBool("sound_close")!;
      } else {
        Globals.playSoundClose = false;
      }
      //});
    } catch(e){
      print(e.toString());
    }
    setState(() {
      name.text = Globals.user.name;
      surname.text = Globals.user.surname;
    });

  }

}
