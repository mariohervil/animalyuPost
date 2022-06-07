import 'package:geocoding/geocoding.dart';

class Shelter {
  String name;
  String email;
  String phone;
  String address;
  String id;
  late List<Location> location;
  late String lat;
  late String lng;

  void a() async {
    location = await locationFromAddress(address);
    lat = location.first.latitude.toString();
    lng = location.first.longitude.toString();
  }

  Shelter({required this.id,required this.name,
    required this.email,
    required this.phone,
    required this.address});
}
