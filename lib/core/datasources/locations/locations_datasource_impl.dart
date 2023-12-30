import 'dart:convert';

import 'package:dedal/core/datasources/locations/locations_datasource.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:http/http.dart' as http;

class LocationsDataSourceImpl extends LocationsDataSource {
  @override
  Future<List<Place>> getPlaceClose(User user) => http.get(
        Uri.parse(
            'http://52.166.128.133/places/nearby?coordinates${user.posToJson()}'),
        headers: {
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((response) {
        return [];
        if (response.statusCode == 200) {
          print(response.body.length);
          return (jsonDecode(response.body) as List<dynamic>)
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
      ).then((response) {
        if (response.statusCode == 200) {
          return (jsonDecode(response.body) as List<dynamic>)
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
  Future<List<Place>> getPlaceByFilter(User user, String placeId) => http.get(
        Uri.parse('http://52.166.128.133/places/byfilter?filterId=$placeId'),
        headers: {
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((response) {
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          return (jsonDecode(response.body) as List<dynamic>)
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
