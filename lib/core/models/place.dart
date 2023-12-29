import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  Place(
      {this.id,
      this.accessible,
      this.address,
      this.name,
      this.link,
      this.description,
      this.price,
      this.duration,
      this.coordinates,
      this.type,
      this.pict});

  String? id;
  bool? accessible;
  String? address;
  String? name;
  String? link;
  String? description;
  double? price;
  double? duration;
  LatLng? coordinates;
  String? type;
  String? pict;

  factory Place.fromJson(Map<String, Object?> json) {
    try {
      return Place(
        id: json['id']?.toString(),
        accessible: json['accessible'] != null
            ? bool.parse(json['accessible']!.toString())
            : null,
        address: json['address']?.toString(),
        name: json['name']?.toString(),
        link: json['website']?.toString(),
        description: json['description']?.toString(),
        pict: json['photoLink']?.toString(),
        price: json['price'] != null
            ? double.parse(json['price']!.toString())
            : null,
        duration: json['duration'] != null
            ? double.parse(json['duration']!.toString())
            : null,
        coordinates: json['coordinates'] != null
            ? LatLng(
                double.parse(Map<String, Object?>.from(
                        json['coordinates'] as Map<String, Object?>)['x']
                    .toString()),
                double.parse(Map<String, Object?>.from(
                        json['coordinates'] as Map<String, Object?>)['y']
                    .toString()))
            : null,
        type: json['type']?.toString(),
      );
    } catch (e) {
      print('e ==> $e');
      return Place();
    }
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'id': id,
        'name': name,
        'description': description,
        'address': address,
        'price': price,
        'duration': duration,
        'type': type,
        'coordinates': {
          'x': coordinates?.latitude,
          'y': coordinates?.longitude,
        }
      };

  @override
  String toString() => '$name : $description';
}
