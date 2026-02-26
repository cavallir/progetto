import 'dart:convert';

class Ore{
  late List<int> ore;
  // String password;
  Ore({required ore});

  factory Ore.fromMap(Map<String, dynamic> json) => Ore(
      ore: json['ore'],
  );

  static Map<String, dynamic> toMap(Ore ore) =>{
    'ore': ore,
  };

  static String encode(List<Ore> list) => json.encode(
    list.map<Map<String, dynamic>>((list) => toMap(list)).toList(),
  );

  static List<Ore> decode(String list) => (json.decode(list) as List<dynamic>)
      .map<Ore>((list) => Ore.fromMap(list)).toList();

  static List<Ore> oreList() {return [];}
}