import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';

class FilterDataSourceImpl extends FilterDataSource {
  @override
  Future<List<Filter>?> getAll(String token) async => http.get(
        Uri.parse('http://52.166.128.133/filter/'),
        headers: {'x-access-token': token, 'Accept': '*/*'},
      ).then((result) {
        if (result.statusCode == 200) {
          final filters = (jsonDecode(result.body) as List<Object?>)
              .map((e) => Filter.fromJson(e as Map<String, Object?>))
              .toList();
          return (filters);
        }
        return null;
      });

  @override
  Future<bool> setinfoUser(User user) async {
    print('start => http://52.166.128.133/user/?id=${user.id}');
    print(
      jsonEncode({
        'time': user.info?.time,
        'budget': user.info?.budget,
        'filter': user.info?.filter,
        'map': 'map-${user.id}',
      }),
    );
    return await http.post(
      Uri.parse('http://52.166.128.133/user/?id=${user.id}'),
      body: jsonEncode({
        'time': user.info?.time,
        'budget': user.info?.budget,
        'filter': user.info?.filter,
        'map': 'map-${user.id}',
      }),
      headers: {
        'x-access-token': user.token!,
        'Accept': '*/*',
        'Content-type': 'application/json',
      },
    ).then((result) {
      print('result >= $result');
      return result.statusCode == 200;
    });
  }

  @override
  Future<List<Place>?> getPlaces(User user) async => http.post(
        Uri.parse('http://52.166.128.133/lambda/places/?id=${user.id}'),
        headers: {
          'x-access-token': user.token!,
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((result) {
        if (result.statusCode == 200) {
          return (jsonDecode(result.body) as List<dynamic>)
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
  Future<String?> getPath(User user) async {
    return http
        .post(
            Uri.parse(
                'http://52.166.128.133/lambda/pathfinding/?id=${user.id}'),
            headers: {
              'x-access-token': user.token!,
              'Accept': '*/*',
              'Content-type': 'application/json',
            },
            body: jsonEncode({
              'position': {
                'x': 50.63129792192402,
                'y': 3.0594292312975506,
              },
              'places': user.places?.map((e) => e.toJson()).toList(),
            }))
        .then((result) {
      if (result.statusCode == 200) {
        final payload = jsonDecode(result.body)['Payload'];
        if (payload != null) {
          return jsonDecode(payload)['mapPath'];
        }
      }
      return null;
    });
  }

  @override
  Future<Map<String, Object>?> getMap(User user) async => await http.get(
        Uri.parse('http://52.166.128.133/map/?id=${user.id}'),
        headers: {
          'x-access-token': user.token!,
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((result) {
        if (result.statusCode == 200) {
          return Map<String, Object>.from(jsonDecode(result.body));
        }
        return null;
      });

  @override
  Future<Place?> getPlace(String placeId) async {
    return await http.get(
      Uri.parse('http://52.166.128.133/places/$placeId'),
      headers: {
        'Accept': '*/*',
        'Content-type': 'application/json',
      },
    ).then((result) {
      if (result.statusCode == 200) {
        return Place.fromJson(jsonDecode(result.body));
      }
      return null;
    });
  }
}
