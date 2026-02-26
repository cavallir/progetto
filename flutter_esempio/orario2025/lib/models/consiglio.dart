
class Consiglio{
  String mese;
  List<DataConsiglio> consigli = <DataConsiglio>[];

  Consiglio({required this.mese});
}

class DataConsiglio{
  String data;
  String orario;
  String classe;

  DataConsiglio({required this.data, required this.orario, required this.classe});

  factory DataConsiglio.fromJson(dynamic json) {

    return DataConsiglio(
      data: json['data'],
      orario: json['orario'],
      classe: json['classe']
    );
  }

  Map toJson() => {
    "data": data,
    "orario": orario,
    "classe": classe
  };
}
