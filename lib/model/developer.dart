import 'dart:convert';

class Developer {
  final String name;
  final int age;

  Developer(this.name, this.age);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  static Developer fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Developer(
      map['name'],
      map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  static Developer fromJson(String source) => fromMap(json.decode(source));
}
