// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) => Animal(
      json['name'] as String,
      json['weight'] as String,
      json['birthdate'] as String,
      json['sex'] as String,
      json['animal_type'] as String,
      json['race_name'] as String,
      json['chip'] as String,
    );

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'birthdate': instance.birthdate,
      'sex': instance.sex,
      'animal_type': instance.animal_type,
      'race_name': instance.race_name,
      'chip': instance.chip,
    };
