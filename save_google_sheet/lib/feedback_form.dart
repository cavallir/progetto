// Definizione della classe modello che rappresenta i dati del modulo
class FeedBackForm {
  // Variabili private
  String lastName;
  String firstName;
  String email;
  String mobile;

  ///HO MESSO LE VARIABILI PUBBLICHE X PROVARE SE VA

  // Costruttore: assegna i valori passati alle variabili della classe
  FeedBackForm(
    this.lastName,
    this.firstName,
    this.email,
    this.mobile,
  );

  // Metodo per convertire i dati in parametri URL standard.
  // Esempio: ?nome=Rossi&cognome=Mario&numerotelefono=123&email=a@b.com

  ///AGGIUNTO DOPO
  Map<String, dynamic> toJson() => {
        'cmd': 'create',
        'nome': lastName, // Lo script Google cerca p.parameter.nome
        'cognome': firstName, // Lo script Google cerca p.parameter.cognome
        'telefono': mobile,
        'email': email,
      };

  String toParams() =>
      "?nome=$lastName&cognome=$firstName&telefono=$mobile&email=$email";

  // Metodo avanzato che aggiunge un parametro di comando (es. "insert" o "update")
  // utile per dire al Google Apps Script quale azione eseguire.
  String cmdParams(String cmd) =>
      "?cmd=$cmd&nome=$lastName&cognome=$firstName&telefono=$mobile&email=$email";
}
