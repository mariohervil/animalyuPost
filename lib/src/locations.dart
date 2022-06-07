import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoding/geocoding.dart';

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Office {
  Office({
    required this.address,
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String address;
  final String id;
  final double lat;
  final double lng;
  final String name;
  final String phone;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.offices,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
}

@JsonSerializable()
class Protectora {
  Protectora({
    required this.address,
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
  });

  factory Protectora.fromJson(Map<String, dynamic> json) =>
      _$ProtectoraFromJson(json);

  Map<String, dynamic> toJson() => _$ProtectoraToJson(this);

  final String address;
  final String id;
  final double lat;
  final double lng;
  final String name;
  final String phone;
}

Future<Locations> getSheltersLocations() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Pick the info of the json in the url of above
/*  try {
    final response = await http.get(Uri.parse(googleLocationsURL));
    if (response.statusCode == 200) {
      return Locations.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }*/

  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations.json'),
    ),
  );
}
