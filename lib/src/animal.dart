import 'package:json_annotation/json_annotation.dart';
part 'animal.g.dart';

@JsonSerializable()
class Animal{

  String name;
  double weight;
  String birthdate;
  String sex;
  String animalType;
  String raceName;
  int chip;

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalToJson(this);

  Animal(this.name, this.weight, this.birthdate, this.sex, this.animalType, this.raceName, this.chip);


}