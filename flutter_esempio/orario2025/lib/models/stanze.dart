class Stanze {
  List<String> aule = <String>[];
  List<List<String>> lun = <List<String>>[];
  List<List<String>> mar = <List<String>>[];
  List<List<String>> mer = <List<String>>[];
  List<List<String>> gio = <List<String>>[];
  List<List<String>> ven = <List<String>>[];
  List<List<String>> sab = <List<String>>[];

  Stanze({
    required this.aule,
    required this.lun,
    required this.mar,
    required this.mer,
    required this.gio,
    required this.ven,
    required this.sab,
  });

  factory Stanze.fromJson(dynamic json) {
    return Stanze(
      aule: List.from(json['aule']),
      lun: List.from(json['lun']),
      mar: List.from(json['mar']),
      mer: List.from(json['mer']),
      gio: List.from(json['gio']),
      ven: List.from(json['ven']),
      sab: List.from(json['sabato']),
    );
  }

  Map toJson() => {
    "classi": aule,
    "lun": lun,
    "mar": mar,
    "mer": mer,
    "gio": gio,
    "ven": ven,
    "sab": sab,
  };
}
