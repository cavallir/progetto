import 'package:flutter/material.dart';
import 'package:save_google_sheet/classe_read.dart';  // Importa la logica di lettura
import 'package:save_google_sheet/classe_write.dart'; // Importa la logica di scrittura
import 'package:save_google_sheet/feedback_form.dart';
import 'controller.dart';
import 'dart:convert' as convert;


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen, // Tema coerente con le altre classi
      ),
      home: const HomePage(title: 'What you want to do?'),
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
  // Chiavi globali (qui istanziate ma non strettamente necessarie per dei semplici pulsanti)
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)), 
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              
              // PULSANTE PER ANDARE ALLA SCRITTURA
              ElevatedButton(
                onPressed: () {
                  // Chiama la funzione classe_write() definita in classe_write.dart
                  // Questo riavvia l'app caricando la schermata di inserimento dati
                  classe_write();
                },
                child: const Text("Send data"),
              ),
              
              const SizedBox(height: 10),
              
              // PULSANTE PER ANDARE ALLA LETTURA
              ElevatedButton(
                onPressed: () {
                  // Chiama la funzione classe_read() definita in classe_read.dart
                  // Questo riavvia l'app caricando la lista dei membri
                  classe_read();
                },
                child: const Text("Read data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}