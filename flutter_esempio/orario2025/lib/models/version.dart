
class Versione{
  late String rel;
  late String date;

  Versione({required rel, required date});

  factory Versione.fromJson(Map<String, dynamic> json) => Versione(
    rel: json['rel'],
    date: json['date']
  );

  Map toJson() => {
    'rel': rel,
    'date': date,
  };

}