// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      address: json['address'] as String,
      id: json['id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'phone': instance.phone,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      offices: (json['offices'] as List<dynamic>)
          .map((e) => Office.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'offices': instance.offices,
    };

Protectora _$ProtectoraFromJson(Map<String, dynamic> json) => Protectora(
      address: json['address'] as String,
      id: json['id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$ProtectoraToJson(Protectora instance) =>
    <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'phone': instance.phone,
    };
