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
          print('result ==> ${result.body}');
          final filters = (jsonDecode(result.body) as List<Object?>)
              .map((e) => Filter.fromJson(e as Map<String, Object?>))
              .toList();
          return (filters);
        }
        return null;
      });

  // @override
  // Future<Info?> getInfoUser(String token, String userId) {
  //   // TODO: implement getInfoUser
  //   throw UnimplementedError();
  // }

  // @override
  // Future<bool> setinfoUser(User user) {
  //   // TODO: implement setinfoUser
  //   throw UnimplementedError();
  // }
}
