import 'package:flutter/material.dart';
import 'package:save_google_sheet/feedback_form.dart'; 
import 'package:save_google_sheet/main.dart';         
import 'controller.dart';
import 'dart:convert' as convert;
import 'dati/membro.dart'; // Importa il modello Member

// Funzione di avvio che riceve il membro da modificare
void classe_update(Member membro) => runApp(UpdateApp(membro: membro));

class UpdateApp extends StatelessWidget {
  final Member membro;
  const UpdateApp({Key? key, required this.membro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Data',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: HomePageUpdate(title: 'Update GoogleSheet', membro: membro),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePageUpdate extends StatefulWidget {
  final String title;
  final Member membro;
  const HomePageUpdate({Key? key, required this.title, required this.membro}) : super(key: key);

  @override
  State<HomePageUpdate> createState() => _HomePageUpdateState();
}

class _HomePageUpdateState extends State<HomePageUpdate> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // PRE-COMPILAZIONE DEI CAMPI con i dati ricevuti
    lastNameController.text = widget.membro.nome;
    firstNameController.text = widget.membro.cognome;
    mobileController.text = widget.membro.telefono;
    emailController.text = widget.membro.email;
  }

  void _submitForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      
      FeedBackForm feedBackForm = FeedBackForm(
        lastNameController.text,
        firstNameController.text,
        mobileController.text,
        emailController.text,
      );

      FormController formController = FormController((String response) {
        print(response);
        var resp = convert.jsonDecode(response)['ans'];
        if (resp == "OK") {
          _showSnackBar("Dati Aggiornati!");
          // Dopo un breve delay torna al main (o alla lista)
          Future.delayed(const Duration(seconds: 1), () => main());
        } else {
          _showSnackBar("Errore durante l'aggiornamento");
        }
      });

      _showSnackBar("Aggiornamento in corso...");

      // COMANDO UPDATE con l'ID del membro
      // Questo dice allo script: "Cerca questa riga e scrivi i nuovi dati"
      String comandoUpdate = "update&id=${widget.membro.id}";
      formController.submitCommandForm(feedBackForm, comandoUpdate);
    }
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(milliseconds: 800)),
    );
  }

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Modifica ID: ${widget.membro.id}", 
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
              ),
              TextFormField(
                controller: lastNameController,
                validator: (val) => val!.isEmpty ? "Mettere Nome Valido" : null,
                decoration: const InputDecoration(hintText: "NOME"),
              ),
              TextFormField(
                controller: firstNameController,
                validator: (val) => val!.isEmpty ? "Mettere Cognome Valido" : null,
                decoration: const InputDecoration(hintText: "COGNOME"),
              ),
              TextFormField(
                controller: mobileController,
                validator: (val) => val!.isEmpty ? "Mettere Numero Telefono Valido" : null,
                decoration: const InputDecoration(hintText: "TELEFONO"),
              ),
              TextFormField(
                controller: emailController,
                validator: (val) => val!.isEmpty ? "Mettere Email Valida" : null,
                decoration: const InputDecoration(hintText: "EMAIL"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("AGGIORNA DATI"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => main(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                child: const Text("Annulla e Torna Indietro", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}