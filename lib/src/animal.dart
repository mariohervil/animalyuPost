// To parse this JSON data, do
//
//     final animal = animalFromJson(jsonString);

import 'dart:convert';

Animals animalFromJson(String str) => Animals.fromJson(json.decode(str));

String animalToJson(Animals data) => json.encode(data.toJson());

class Animals {
  Animals({
    required this.animals,
  });

  List<Animal> animals;

  factory Animals.fromJson(Map<String, dynamic> json) => Animals(
        animals: List<Animal>.from(
            json["animals"].map((x) => Animal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "animals": List<dynamic>.from(animals.map((x) => x.toJson())),
      };
}

class Animal {
  Animal({
    required this.name,
    required this.weight,
    required this.birthdate,
    required this.sex,
    required this.animalType,
    required this.raceName,
    required this.chip,
  });

  String name;
  String weight;
  String birthdate;
  String sex;
  String animalType;
  String raceName;
  String chip;

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        name: json["name"],
        weight: json["weight"],
        birthdate: json["birthdate"],
        sex: json["sex"],
        animalType: json["animal_type"],
        raceName: json["race_name"],
        chip: json["chip"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "weight": weight,
        "birthdate":
            birthdate,
        "sex": sex,
        "animal_type": animalType,
        "race_name": raceName,
        "chip": chip,
      };
}
