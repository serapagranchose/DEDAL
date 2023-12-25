import 'dart:convert';

import 'package:dedal/core/datasources/locations/locations_datasource.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:http/http.dart' as http;

class LocationsDataSourceImpl extends LocationsDataSource {
  @override
  Future<List<Place>> getPlaceClose(User user) => http.get(
        //TODO(dev): replace with right coorinates
        Uri.parse(
            'http://52.166.128.133/places/nearby?coordinates={x: 50.63904, y: 3.05867}'),
        headers: {
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      )
          // body: jsonEncode({'position': user.posToJson()}))
          .then((value) {
        if (value.statusCode == 200) {
          return (jsonDecode(value.body) as List<dynamic>)
              .map(
                (e) => Place.fromJson(
                  Map<String, Object?>.from(
                    e as Map<Object, Object?>,
                  ),
                ),
              )
              .toList();
        }
        return [];
      });

  @override
  Future<List<Place>> getPlaceFilter(User user) => http.get(
        Uri.parse(
            'http://52.166.128.133/places/places_not_filter/?id=${user.id}'),
        headers: {
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return (jsonDecode(value.body) as List<dynamic>)
              .map(
                (e) => Place.fromJson(
                  Map<String, Object?>.from(
                    e as Map<Object, Object?>,
                  ),
                ),
              )
              .toList();
        }
        return [];
      });
}
