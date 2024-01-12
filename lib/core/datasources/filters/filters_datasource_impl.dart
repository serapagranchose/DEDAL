import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:dedal/core/dtos/change_username_dto.dart';

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
  Future<bool> setinfoUser(User user) async => await http.post(
        Uri.parse('http://52.166.128.133/user/?id=${user.id}'),
        body: jsonEncode({
          'time': user.info?.time,
          'budget': user.info?.budget,
          'filter': user.info?.filter,
          'map': 'map-${user.id}',
          'pmr': user.info?.accecibility,
        }),
        headers: {
          'x-access-token': user.token!,
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((result) => result.statusCode == 200);

  @override
  Future<List<Place>?> getPlaces(User user) async => http.post(
        Uri.parse('http://52.166.128.133/lambda/places/?id=${user.id}'),
        headers: {
          'x-access-token': user.token!,
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((result) {
        print(user.id);
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
              'position': user.posToJson(),
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
    return await http.post(
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

  @override
  Future<bool> setUserName(ChangeUsernameDto info) async => await http.post(
        Uri.parse('http://52.166.128.133/user/username?id=${info.user?.id}'),
        body: jsonEncode({
          'username': info?.username,
        }),
        headers: {
          'x-access-token': info?.user?.token ?? '',
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((result) => result.statusCode == 200);
}
