import 'package:dedal/core/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

void Function() userTest = () {
  final user = User(
    name: 'test_name',
    id: 'test_id',
    email: 'test_email',
    token: 'test_token',
    pos: const LatLng(10, 10),
    places: [],
  );
  final nullUser = User();
  test('User created', () {
    expect(user.isNotNull, true);
  });

  test('User to Json', () {
    expect(user.toJson(), {
      'username': 'test_name',
      'email': 'test_email',
      'lastInfo': null,
      'token': 'test_token',
      'place': [],
      'id': 'test_id',
      'pos': {'x': 10.0, 'y': 10.0}
    });
  });
  test('User posToJson', () {
    expect(user.posToJson(), {
      'x': 10,
      'y': 10,
    });
  });
  test('User posToJson -- null', () {
    expect(nullUser.posToJson(), {
      'x': null,
      'y': null,
    });
  });
};
