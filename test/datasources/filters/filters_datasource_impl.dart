import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/dtos/change_username_dto.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';

class FilterDataSourceImplTest extends FilterDataSource {
  @override
  Future<List<Filter>?> getAll(String token) async =>
      token == 'test_token' ? [] : null;

  @override
  Future<bool> setinfoUser(User user) async =>
      user.name == 'test_name' ? true : false;

  @override
  Future<List<Place>?> getPlaces(User user) async =>
      user.name == 'test_name' ? [] : null;

  @override
  Future<String?> getPath(User user) async =>
      user.name == 'test_name' ? 'test_path' : null;

  @override
  Future<Map<String, Object>?> getMap(User user) async =>
      user.name == 'test_name' ? {} : null;

  @override
  Future<Place?> getPlace(String placeId) async =>
      placeId == 'test_id' ? Place(name: 'test_name') : null;

  @override
  Future<bool> setUserName(ChangeUsernameDto info) async =>
      info.username == 'test_name' ? true : false;
}
