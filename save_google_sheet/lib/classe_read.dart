import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:save_google_sheet/main.dart';
import 'dati/membro.dart';
import 'costanti.dart';
import 'comandi.dart';
import 'package:save_google_sheet/classe_update.dart';

// LISTA PUBBLICA (Senza underscore) per essere vista da classe_update
final List<Member> members = [];

void classe_read() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lettura Dati',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const MyHomePage(title: 'Anagrafica Google Sheet'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Future<void> _loadData() async {
    try {
      final response = await http.get(Uri.parse(URL));
      if (response.statusCode == 200) {
        setState(() {
          members.clear(); // Svuota prima di riempire
          final dataList = json.decode(response.body);
          for (final item in dataList['anagrafica']) {
            members.add(Member(
              item["ID"]?.toString() ?? '0',
              item["NOME"]?.toString() ?? '',
              item["COGNOME"]?.toString() ?? '',
              item["EMAIL"]?.toString() ?? '',
              item["TELEFONO"]?.toString() ?? '',
            ));
          }
        });
      }
    } catch (exc) {
      print("Errore caricamento: $exc");
    }
  }

  Future<void> _deleteData(String idDelete) async {
    try {
      Comandi comandi = Comandi("delete");
      final urlEliminazione = Uri.parse("$URL${comandi.cmdParams()}&id=$idDelete");
      await http.get(urlEliminazione);
      setState(() {
        members.removeWhere((m) => m.id == idDelete);
      });
    } catch (exc) {
      print("Errore eliminazione: $exc");
    }
  }

  @override
  void initState() {
    super.initState();
    // Se la lista è vuota, scarica. Se è già piena (es. torni da un Annulla), resta così.
    if (members.isEmpty) {
      _loadData();
    }
  }

  Widget _buildRow(int i) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _infoRow(Icons.person, members[i].nome),
            _infoRow(Icons.person_outline, members[i].cognome),
            _infoRow(Icons.call, members[i].telefono),
            _infoRow(Icons.email, members[i].email),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteData(members[i].id),
                ),
                const SizedBox(width: 40),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => classe_update(members[i]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.lightGreen, size: 28),
        const SizedBox(width: 15),
        Text(text, style: _biggerFont),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () => main(),
            child: const Text("Turn Back", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: members.isEmpty 
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) => _buildRow(index),
            ),
    );
  }
}