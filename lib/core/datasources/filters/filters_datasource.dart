import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:dedal/core/dtos/change_username_dto.dart';

abstract class FilterDataSource extends BaseDataSource {
  Future<List<Filter>?> getAll(String token);
  Future<bool> setinfoUser(User user);
  Future<List<Place>?> getPlaces(User user);
  Future<String?> getPath(User user);
  Future<Map<String, Object>?> getMap(User user);
  Future<Place?> getPlace(String placeId);
  Future<bool> setUserName(ChangeUsernameDto info);
}
