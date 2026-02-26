import 'package:flutter/material.dart';
import 'package:save_google_sheet/feedback_form.dart'; // Modello dati per il feedback
import 'package:save_google_sheet/main.dart';         // Per tornare alla home principale
import 'controller.dart';                            // Gestisce la logica di invio HTTP
import 'dart:convert' as convert;                   // Per decodificare la risposta JSON del server

// Punto di ingresso per la funzionalità di scrittura
void classe_write() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const HomePage(title: 'Write GoogleSheet'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Chiavi globali per gestire la validazione del form e lo stato dello Scaffold
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller per recuperare il testo digitato dall'utente nei vari campi
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  // Funzione che raccoglie i dati e li invia al FormController
  void _submitForm(var cmd) {
    // 1. Controlla se il form è valido (tutti i campi compilati correttamente)
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      
      // 2. Crea un oggetto FeedBackForm con i dati estratti dai controller
      FeedBackForm feedBackForm = FeedBackForm(
        lastNameController.text,
        firstNameController.text,
        mobileController.text,
        emailController.text,
      );

      // 3. Inizializza il controller che gestirà la chiamata HTTP
      FormController formController = FormController((String response) {
        print(response);
        // Decodifica lo stato della risposta
        var resp = convert.jsonDecode(response)['status'];
        if (resp == FormController.STATUS_SUCCESS) {
          _showSnackBar("Feedback submitted"); // Successo
        } else {
          _showSnackBar("Error occured");      // Errore
        }
      });

      _showSnackBar("Submitting Feedback");

      // 4. Invia i dati: se cmd è null usa il metodo standard, altrimenti invia un comando specifico
      if (cmd == null) {
        formController.submitForm(feedBackForm);
      } else {
        formController.submitCommandForm(feedBackForm, cmd);
      }
    }
  }

  // Mostra un messaggio temporaneo in basso (SnackBar)
  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey, // Collega il form alla chiave per la validazione
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: ListView(
            children: <Widget>[
              // Campo di input per il Nome
              TextFormField(
                controller: lastNameController,
                validator: (val) => val!.isEmpty ? "Mettere Nome Valido" : null,
                decoration: const InputDecoration(hintText: "Nome"),
              ),
              // Campo di input per il Cognome
              TextFormField(
                controller: firstNameController,
                validator: (val) => val!.isEmpty ? "Mettere Cognome Valido" : null,
                decoration: const InputDecoration(hintText: "Cognome"),
              ),
              // Campo di input per il Telefono
              TextFormField(
                controller: mobileController,
                validator: (val) => val!.isEmpty ? "Mettere Numero Telefono Valido" : null,
                decoration: const InputDecoration(hintText: "Numero Telefono"),
              ),
              // Campo di input per l'Email
              TextFormField(
                controller: emailController,
                validator: (val) => val!.isEmpty ? "Mettere Email Valida" : null,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(height: 20),
              // Pulsante per inviare i dati
              ElevatedButton(
                onPressed: () => _submitForm(null),
                child: const Text("Send data"),
              ),
              const SizedBox(height: 10),
              // Pulsante per tornare al main principale
              ElevatedButton(
                onPressed: () => main(),
                child: const Text("Turn Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}