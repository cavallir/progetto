import 'package:flutter/material.dart';
import 'package:save_google_sheet/feedback_form.dart'; 
import 'package:save_google_sheet/main.dart';         
import 'controller.dart';                            
import 'dart:convert' as convert;                   

// Punto di ingresso
void classe_write() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Write Data',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const HomePage(title: 'Inserimento GoogleSheet'),
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
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller per i campi di testo
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  void _submitForm(var cmd) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      
      // 1. Mostra un cerchio di caricamento per evitare doppi click
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.lightGreen)),
      );

      FeedBackForm feedBackForm = FeedBackForm(
        lastNameController.text,
        firstNameController.text,
        mobileController.text,
        emailController.text,
      );

      FormController formController = FormController((String response) {
        // 2. Chiudi il cerchio di caricamento appena arriva la risposta
        Navigator.of(context, rootNavigator: true).pop();

        print("Risposta Server: $response");
        var resp = convert.jsonDecode(response)['ans'];

        if (resp == "OK" || resp == FormController.STATUS_SUCCESS) {
          // 3. Mostra Pop-up Successo
          showFeedbackDialog(context, true).then((_) {
            main(); // Torna alla home solo dopo il click su OK
          });
        } else {
          // 3. Mostra Pop-up Errore
          showFeedbackDialog(context, false);
        }
      });

      // Esecuzione invio
      if (cmd == null) {
        formController.submitForm(feedBackForm);
      } else {
        formController.submitCommandForm(feedBackForm, cmd);
      }
    }
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
              const SizedBox(height: 20),
              
              // NOME
              TextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.name,
                validator: (val) => val!.isEmpty ? "Mettere Nome Valido" : null,
                decoration: _buildInputDecoration("Nome", Icons.insert_emoticon_sharp, "NOME"),
              ),
              const SizedBox(height: 10),

              // COGNOME
              TextFormField(
                controller: firstNameController,
                keyboardType: TextInputType.name,
                validator: (val) => val!.isEmpty ? "Mettere Cognome Valido" : null,
                decoration: _buildInputDecoration("Cognome", Icons.insert_emoticon_sharp, "COGNOME"),
              ),
              const SizedBox(height: 10),

              // TELEFONO
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                validator: (val) => val!.isEmpty ? "Mettere Numero Telefono Valido" : null,
                decoration: _buildInputDecoration("Telefono", Icons.import_contacts, "TELEFONO"),
              ),
              const SizedBox(height: 10),

              // EMAIL
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty ? "Mettere Email Valida" : null,
                decoration: _buildInputDecoration("e-mail", Icons.email_outlined, "EMAIL"),
              ),
              const SizedBox(height: 20),

              // BOTTONE INVIA
              ElevatedButton(
                onPressed: () => _submitForm('create'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(100, 45)),
                child: const Text("INVIA DATI"),
              ),
              const SizedBox(height: 10),

              // BOTTONE ANNULLA
              ElevatedButton(
                onPressed: () => main(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  minimumSize: const Size(100, 45),
                ),
                child: const Text("Annulla e Torna Indietro", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Funzione helper per decorare i campi (per non ripetere codice)
  InputDecoration _buildInputDecoration(String label, IconData icon, String hint) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}

// --- FUNZIONE POP-UP (Mettila in fondo al file) ---
Future<void> showFeedbackDialog(BuildContext context, bool success) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          success ? 'Operazione Riuscita' : 'Errore!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: success ? Colors.green : Colors.red,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              success ? Icons.check_circle_outline : Icons.error_outline,
              size: 80.0,
              color: success ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 15),
            Text(
              success 
                ? "I dati sono stati salvati correttamente." 
                : "Impossibile inviare i dati.\nControlla la connessione.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text('OK', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      );
    },
  );
}