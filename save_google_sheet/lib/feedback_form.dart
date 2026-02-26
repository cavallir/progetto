import 'package:flutter/material.dart';

// Definizione della classe modello che rappresenta i dati del modulo
class FeedBackForm {
  // Variabili private
  String _lastName;
  String _firstName;
  String _email;
  String _mobile;

  // Costruttore: assegna i valori passati alle variabili della classe
  FeedBackForm(
    this._lastName,
    this._firstName,
    this._email,
    this._mobile,
  );

  // Metodo per convertire i dati in parametri URL standard.
  // Esempio: ?nome=Rossi&cognome=Mario&numerotelefono=123&email=a@b.com
  String toParams() =>
      "?nome=$_lastName&cognome=$_firstName&numerotelefono=$_mobile&email=$_email";

  // Metodo avanzato che aggiunge un parametro di comando (es. "insert" o "update")
  // utile per dire al Google Apps Script quale azione eseguire.
  String cmdParams(String cmd) =>
      "?cmd=$cmd&nome=$_lastName&cognome=$_firstName&numerotelefono=$_mobile&email=$_email";
}