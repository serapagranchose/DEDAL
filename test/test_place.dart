import 'package:dedal/core/models/place.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

void Function() placeTest = () {
  final place = Place(
    name: 'test_name',
    id: 'test_id',
    accessible: true,
    address: 'test_adresse',
    link: 'test_link',
    description: 'test_description',
    price: 10,
    duration: 12,
    coordinates: const LatLng(10, 12),
    type: 'test_type',
  );
  test('Place created', () {
    expect(place.isNotNull, true);
  });

  test('Place to Json', () {
    expect(place.toJson(), {
      'id': 'test_id',
      'name': 'test_name',
      'description': 'test_description',
      'address': 'test_adresse',
      'price': 10.0,
      'duration': 12.0,
      'type': 'test_type',
      'coordinates': {'x': 10.0, 'y': 12.0}
    });
  });
};
