import 'package:flutter/material.dart';
import 'package:save_google_sheet/main.dart';
import 'package:save_google_sheet/classe_read.dart'; // Importante per accedere a 'members'
import 'controller.dart';
import 'dart:convert' as convert;
import 'dati/membro.dart';
import 'package:save_google_sheet/feedback_form.dart'; // <--- AGGIUNGI QUESTO

void classe_update(Member membro) => runApp(UpdateApp(membro: membro));

class UpdateApp extends StatelessWidget {
  final Member membro;
  const UpdateApp({Key? key, required this.membro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: HomePageUpdate(membro: membro),
    );
  }
}

class HomePageUpdate extends StatefulWidget {
  final Member membro;
  const HomePageUpdate({Key? key, required this.membro}) : super(key: key);

  @override
  State<HomePageUpdate> createState() => _HomePageUpdateState();
}

class _HomePageUpdateState extends State<HomePageUpdate> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeController;
  late TextEditingController cognomeController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    // Inizializza i controller con i dati esistenti
    nomeController = TextEditingController(text: widget.membro.nome);
    cognomeController = TextEditingController(text: widget.membro.cognome);
    emailController = TextEditingController(text: widget.membro.email);
    phoneController = TextEditingController(text: widget.membro.telefono);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Mostra caricamento
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Creiamo l'oggetto con i nuovi dati
      // Attenzione: l'ordine dei parametri deve corrispondere al tuo FeedBackForm
      var feedbackForm = FeedBackForm(
        nomeController.text,
        cognomeController.text,
        phoneController.text, // Assicurati che l'ordine sia lo stesso del controller
        emailController.text,
      );

      FormController formController = FormController((String response) {
        Navigator.of(context).pop(); // Chiudi caricamento

        var resp = convert.jsonDecode(response)['ans'];
        if (resp == "OK") {
          // --- LA MODIFICA CHE RISOLVE IL TUO PROBLEMA ---
          members.clear(); // Svuota la lista globale
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Dati aggiornati con successo!")),
          );
          
          // Torna alla lista dopo 1 secondo
          Future.delayed(const Duration(seconds: 1), () => classe_read());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Errore durante l'aggiornamento")),
          );
        }
      });

      formController.submitCommandForm(feedbackForm, "update&id=${widget.membro.id}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modifica Membro")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text("Modifica ID: ${widget.membro.id}", 
                 style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 20),
            _buildField(nomeController, "Nome", Icons.person),
            _buildField(cognomeController, "Cognome", Icons.person_outline),
            _buildField(phoneController, "Telefono", Icons.phone, TextInputType.phone),
            _buildField(emailController, "Email", Icons.email, TextInputType.emailAddress),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
              child: const Text("SALVA MODIFICHE"),
            ),
            TextButton(
              onPressed: () => classe_read(),
              child: const Text("Annulla"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, [TextInputType type = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? "Campo obbligatorio" : null,
      ),
    );
  }
}