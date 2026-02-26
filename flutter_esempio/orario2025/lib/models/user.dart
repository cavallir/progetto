import 'dart:convert';

class User{
  late String name;
  late String surname;
  // String password;
  User({required name, required surname});

  factory User.fromMap(Map<String, dynamic> json) => User(
    name: json['name'],
    surname: json['surname']
  );

  static Map<String, dynamic> toMap(User user) =>{
    'name': user.name,
    'surname': user.surname
  };

  static String encode(List<User> list) => json.encode(
    list.map<Map<String, dynamic>>((list) => toMap(list)).toList(),
  );

  static List<User> decode(String list) => (json.decode(list) as List<dynamic>)
      .map<User>((list) => User.fromMap(list)).toList();

  
  static List<User> userList() {return [];}

}