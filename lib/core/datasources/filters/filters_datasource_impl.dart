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
    print('user.info => ${user.info}');
    return await http.post(
      Uri.parse('http://52.166.128.133/user/?id=${user.id}'),
      body: jsonEncode({'lastinfo': user.info!.toJson(user.token!)}),
      headers: {
        'x-access-token': user.token!,
        'Accept': '*/*',
        'Content-type': 'application/json',
      },
    ).then((value) {
      return value.statusCode == 200;
    });
  }

  @override
  Future<List<Place>?> getPlaces(User user) async => http.post(
        Uri.parse('http://52.166.128.133/places_generate/?id=${user.id}'),
        headers: {
          'x-access-token': user.token!,
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((value) {
        print('result => ${value.body}');
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
  Future<String?> getPath(User user) async {
    print('user =<w ${user.posToJson()}');
    return http
        .post(Uri.parse('http://52.166.128.133/path_finding/?id=${user.id}'),
            headers: {
              'x-access-token': user.token!,
              'Accept': '*/*',
              'Content-type': 'application/json',
            },
            body: jsonEncode({
              'position': user.posToJson(),
              'places': user.places?.map((e) => e?.toJson()).toList(),
            }))
        .then((value) {
      print('value => ${value.body}');
      if (value.statusCode == 200) {
        print(jsonDecode(value.body)['Payload']);
        final payload = jsonDecode(value.body)['Payload'];
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
      ).then((value) {
        if (value.statusCode == 200) {
          return Map<String, Object>.from(jsonDecode(value.body));
        }
        return null;
      });
}
