import 'package:flutter/material.dart';
import 'dart:convert'; // Necessario per convertire la stringa JSON ricevuta in oggetti Dart
import 'package:http/http.dart'
    as http; // Package per effettuare chiamate di rete (GET/POST)
// import 'package:save_google_sheet/classe_update.dart'; // Import commentato (non usato)
import 'package:save_google_sheet/main.dart'; // Import per poter tornare alla funzione main principale
import 'dati/membro.dart'; // Import della classe modello 'Member' (nome, cognome, etc.)
import 'costanti.dart'; // Qui si trova probabilmente la variabile 'URL' del Google Sheet
import 'comandi.dart'; // Classe che genera i parametri della query (es. ?action=read)
import 'package:save_google_sheet/classe_update.dart';

final _members = <dynamic>[];

// Funzione di avvio specifica per questa visualizzazione
void classe_read() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen, // Colore principale dell'interfaccia
      ),
      home: const MyHomePage(title: 'Prova Lettura Google Sheet'),
      debugShowCheckedModeBanner:
          false, // Rimuove la scritta "Debug" in alto a destra
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
  // Lista dinamica che conterrà gli oggetti Member caricati dal web
  //final _members = <dynamic>[];
  final _biggerFont =
      const TextStyle(fontSize: 18.0); // Stile del testo per i dati
  final _members2 =
      <Member>[]; // Lista tipizzata (opzionale, non usata nel buildRow)

  // Funzione asincrona che scarica i dati da Google Sheets
  Future<void> _loadData() async {
    try {
      // Istanzia la classe Comandi con l'azione "read"
      Comandi comandi = Comandi("read");

      // Effettua la chiamata GET all'URL composto (URL base + parametri del comando)
      final response = await http.get(Uri.parse(URL));
      //final response = await http.get(Uri.parse(URL + comandi.cmdParams()));

      // Notifica a Flutter che i dati sono cambiati per aggiornare l'interfaccia
      setState(() {
        // Decodifica il corpo della risposta JSON
        final dataList = json.decode(response.body);

        // Cicla attraverso i dati contenuti nella chiave 'data1' (il nome dipende dal tuo script Google)
        for (final item in dataList['anagrafica']) {
          // Assegna i valori basandosi sulla posizione delle colonne (0, 1, 2, 3)
          final id = item["ID"] as String? ?? '0';
          final nome = item["NOME"] as String? ?? '';
          final cognome = item["COGNOME"] as String? ?? '';
          final telefono = item["TELEFONO"] as String? ?? '';
          final email = item["EMAIL"] as String? ?? '';

          // Crea un oggetto Member e lo aggiunge alla lista locale
          final member = Member(id, nome, cognome, email, telefono);
          _members.add(member);
        }
      });
    } catch (exc) {
      // Stampa l'errore in console se la chiamata fallisce
      print("Errore durante il caricamento: $exc");
    }
  }

  Future<void> _deleteData(String idDelete) async {
    try {
      Comandi comandi = Comandi("delete");

      final urlEliminazione =
          Uri.parse("$URL${comandi.cmdParams()}&id=$idDelete");

      print("URL FINALE: $urlEliminazione");

      final response = await http.get(urlEliminazione);

      setState(() {
        // Rimuove dalla lista locale il membro che ha quell'ID
        _members.removeWhere((member) => member.id == idDelete);
      });
      print("Eliminazione completata con successo");
    } catch (exc) {
      print("Errore durante l'eliminazione: $exc");
    }
  }

  // Metodo chiamato automaticamente alla creazione del widget
  @override
  void initState() {
    super.initState();
    if (_members.isEmpty) {
      _loadData(); // Avvia il caricamento dei dati appena la pagina è pronta
    }
  }

  // Costruisce la visualizzazione di una singola "cella" della lista
  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              // Riga Nome
              Row(
                children: [
                  const Icon(Icons.person,
                      size: 36.0, color: Colors.lightGreen),
                  const SizedBox(width: 10),
                  Text('${_members[i].nome}', style: _biggerFont),
                ],
              ),
              // Riga Cognome
              Row(
                children: [
                  const Icon(Icons.person_outline,
                      size: 36.0, color: Colors.lightGreen),
                  const SizedBox(width: 10),
                  Text('${_members[i].cognome}', style: _biggerFont),
                ],
              ),
              // Riga Telefono
              Row(
                children: [
                  const Icon(Icons.call, size: 36.0, color: Colors.lightGreen),
                  const SizedBox(width: 10),
                  Text('${_members[i].telefono}', style: _biggerFont),
                ],
              ),
              // Riga Email
              Row(
                children: [
                  const Icon(Icons.email, size: 36.0, color: Colors.lightGreen),
                  const SizedBox(width: 10),
                  Text('${_members[i].email}', style: _biggerFont),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _deleteData(_members[i].id);
                      },
                      //child: const Text("Turn Back"),
                      child: const Icon(Icons.delete),
                    ),
                    const SizedBox(width: 30),
                    // Nel file classe_read.dart, dentro il metodo _buildRow
                    ElevatedButton(
                      onPressed: () {
                        // Passiamo l'intero oggetto membro alla funzione classe_update
                        classe_update(_members[i] as Member);
                      },
                      child: const Icon(
                          Icons.edit), // Icona matita per la modifica
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // Pulsante per tornare alla home dell'applicazione (main)
          ElevatedButton(
            onPressed: () {
              main(); // Chiama la funzione main definita in main.dart
            },
            child: const Text("Turn Back"),
          ),
        ],
      ),
      // ListView.separated crea una lista con una linea di divisione (Divider) tra i membri
      body: ListView.builder(
        itemCount: _members.length, // Numero totale di elementi scaricati
        padding: const EdgeInsets.all(5),
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(
              position); // Chiama buildRow per ogni elemento della lista
        },
      ),

      /*
              ListView.separated(
          itemCount: _members.length, // Numero totale di elementi scaricati
          padding: EdgeInsets.all(5),
            itemBuilder: (BuildContext context, int position) {
              return _buildRow(
                  position); // Chiama buildRow per ogni elemento della lista
            },
            separatorBuilder: (context, index) {
              return const Divider(
                  thickness: 0.0); // Linea divisoria tra i contatti
            }
          ),
      * */
    );
  }
}
