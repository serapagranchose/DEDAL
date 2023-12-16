import 'dart:convert';

import 'package:dedal/core/datasources/locations/locations_datasource.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:http/http.dart' as http;

class LocationsDataSourceImplTest extends LocationsDataSource {
  @override
  Future<List<Place>> getPlaceClose(User user) async =>
      user.name == 'test_name' ? [Place()] : [];

  @override
  Future<List<Place>> getPlaceFilter(User user) async =>
      user.name == 'test_name' ? [Place()] : [];
}
