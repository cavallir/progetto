class Docente {
  String cognome;
  String catt;
  List<String> lun = <String>[];
  List<String> mar = <String>[];
  List<String> mer = <String>[];
  List<String> gio = <String>[];
  List<String> ven = <String>[];
  List<String> sab = <String>[];
  List<String> classi = <String>[];
  //List<List<String>> week = <List<String>>[];



  Docente({
    required this.cognome,
    required this.lun,
    required this.mar,
    required this.mer,
    required this.gio,
    required this.ven,
    required this.sab,
    required this.classi,
    required this.catt,
  });

  factory Docente.fromJson(dynamic json) {
      return Docente(
      cognome: json['cognome'],
      catt: json['cattedra'].toString(),
      lun: json['lun'].cast<String>(),
      mar: json['mar'].cast<String>(),
      mer: json['mer'].cast<String>(),
      gio: json['gio'].cast<String>(),
      ven: json['ven'].cast<String>(),
      sab: json['sab'].cast<String>(),
      classi: List.from(json['classi']),
    );
  }

  Map toJson() => {
    "cognome": cognome,
    "lun": lun,
    "mar": mar,
    "mer": mer,
    "gio": gio,
    "ven": ven,
    "sab": sab,
    "classi": classi,
    "catt": catt,
  };
}
