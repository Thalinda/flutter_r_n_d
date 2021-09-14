import 'dart:io';
class PlaceLocation {
  final double latitute;
  final double longitiude;
  final double address;

  PlaceLocation(
      {required this.address,
      required this.latitute,
      required this.longitiude});
}

class Place {
  final String id;
  final String title;
  final String location;
  final File image;

  Place(
      {required this.id,
      required this.image,
      required this.location,
      required this.title});
}
