import 'package:flutter/material.dart';
import 'package:save_google_sheet/feedback_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'costanti.dart';

class FormController {
  final void Function(String) callback;

  static const STATUS_SUCCESS = "SUCCESS";
  FormController(this.callback);



  /*
  void submitForm(FeedBackForm feedBackForm) async {
    try {
      String stringa = URL + feedBackForm.toParams();

      await http.get(Uri.parse(URL + feedBackForm.toParams())).then((response) {
        //callback(convert.jsonDecode(response.body)['status']);
        callback(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }
  */

  void submitForm(FeedBackForm feedBackForm) async {
  try {
    // Usiamo l'URL con i parametri
    var uri = Uri.parse(URL + feedBackForm.toParams());
    
    // Eseguiamo la GET
    var response = await http.get(uri);

    // DEBUG: Guarda cosa risponde il server prima della callback
    print("Status Code: ${response.statusCode}");
    print("Corpo ricevuto: ${response.body}");

    if (response.statusCode == 302) {
      // Se Google reindirizza, seguiamo il nuovo URL
      var urlRedirect = response.headers['location'];
      var res = await http.get(Uri.parse(urlRedirect!));
      callback(res.body); // Passiamo il BODY (Stringa)
    } else {
      callback(response.body); // Passiamo il BODY (Stringa)
    }
  } catch (exc) {
    print("Errore nel controller: $exc");
  }
}

  
  /*
  void submitCommandForm(FeedBackForm feedBackForm, String cmd) async {
    try {
      String stringa = URL + feedBackForm.cmdParams(cmd);
      await http
          .get(Uri.parse(URL + feedBackForm.cmdParams(cmd)))
          .then((response) {
        //callback(convert.jsonDecode(response.body)['status']);
        callback(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }
  */

  void submitCommandForm(FeedBackForm feedBackForm, String cmd) async {
  try {
    // 1. Costruiamo l'URL con il comando (es. ?cmd=create&nome=...)
    String urlCompleto = URL + feedBackForm.cmdParams(cmd);
    
    // 2. USIAMO POST per attivare la scrittura nello script
    var response = await http.post(Uri.parse(urlCompleto));

    // 3. SE GOOGLE RISPONDE CON 302 (Redirect), DOBBIAMO SEGUIRLO
    if (response.statusCode == 302) {
      var nuovoUrl = response.headers['location'];
      var res = await http.get(Uri.parse(nuovoUrl!));
      callback(res.body); // Qui avrai finalmente {"ans":"OK"}
    } else {
      callback(response.body);
    }
  } catch (exc) {
    print("Errore invio: $exc");
  }
}
}
