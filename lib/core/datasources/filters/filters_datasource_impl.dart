import 'dart:convert';

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/info.dart';
import 'package:dedal/core/models/user.dart';
import 'package:http/http.dart' as http;

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
  Future<void> setinfoUser(User user) async {
    try {
      print('user => $user');
      print('user => ${user.token}');
      print('http://52.166.128.133/user/?id=${user.id}');
      print(user.info?.toJson());
      await http.patch(
        Uri.parse('http://52.166.128.133/user/?id=${user.id}'),
        body: jsonEncode(user.info!.toJson()),
        headers: {
          'x-access-token': user.token!,
          'Accept': '*/*',
          'Content-type': 'application/json',
        },
      ).then((value) => print('value => ${value.body} / ${value.statusCode}'));
    } catch (e) {
      print('error ==> $e');
    }
  }
}
